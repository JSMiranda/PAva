package ist.meic.pa;

import ist.meic.pa.command.Command;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;

import javassist.ClassPool;
import javassist.Loader;
import javassist.Translator;

public final class DebuggerCLI {
	public static boolean retrying;
	public static boolean throwing;
	public static boolean reading;
	public static Object returnObject;
	public static CallStack callStack = new CallStack();

	public static void main(String[] args) {
		try {
			ClassPool pool = ClassPool.getDefault();
			Loader javaLoader = new Loader(pool);
			Translator translator = new DebugTranslator();
			javaLoader.addTranslator(pool, translator);
			String[] restArgs = new String[args.length - 1];
			System.arraycopy(args, 1, restArgs, 0, restArgs.length);
			Class<?> rtClass = javaLoader.loadClass(args[0]);
			rtClass.getDeclaredMethod("main$$debugger",
					new Class[] { String[].class }).invoke(null,
					new Object[] { restArgs });
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static Object execute(String className, String methodName, Object o,
			Object[] args) throws Throwable {

		// reseting state
		retrying = false;
		returnObject = null;
		throwing = false;

		try {
			Class<?> originalClass = Class.forName(className);
			Class<?>[] argsClasses = computeArgsClasses(args);
			Method m = originalClass.getMethod(methodName, argsClasses);
			m.setAccessible(true);
			callStack.push(m, o, args);
			try{
				returnObject = m.invoke(originalClass.cast(o), args);
			} catch(NullPointerException e){
				callStack.pop();
				throw e;
			}
			callStack.pop();
			return returnObject;
		} catch (InvocationTargetException e) {
			System.err.println(e.getCause());
			CheckInput();
			callStack.pop();
			if (retrying) {
				return execute(className, methodName, o, args);
			} else if (throwing) {
				throw e.getCause();
			} else {
				return returnObject;
			}
		}
		
	}

	private static Class<?>[] computeArgsClasses(Object[] args) {
		Class<?>[] argsClasses = new Class<?>[args.length];
		for (int i = 0; i < args.length; i++) {
			if (args[i] == null) {
				argsClasses[i] = Object.class;
			} else {
				argsClasses[i] = args[i].getClass();
				if (argsClasses[i].getName().equals("java.lang.Byte"))
					argsClasses[i] = byte.class;
				if (argsClasses[i].getName().equals("java.lang.Short"))
					argsClasses[i] = short.class;
				if (argsClasses[i].getName().equals("java.lang.Integer"))
					argsClasses[i] = int.class;
				if (argsClasses[i].getName().equals("java.lang.Long"))
					argsClasses[i] = long.class;
				if (argsClasses[i].getName().equals("java.lang.Float"))
					argsClasses[i] = float.class;
				if (argsClasses[i].getName().equals("java.lang.Double"))
					argsClasses[i] = double.class;
				if (argsClasses[i].getName().equals("java.lang.Character"))
					argsClasses[i] = char.class;
				if (argsClasses[i].getName().equals("java.lang.Boolean"))
					argsClasses[i] = boolean.class;
			}
		}
		return argsClasses;
	}

	public static void CheckInput() {
		reading = true;
		while (reading) {
			System.out.flush();
			System.err.print("DebuggerCLI:> ");
			String input = null;
			try {
				BufferedReader br = new BufferedReader(new InputStreamReader(
						System.in));

				input = br.readLine();
			} catch (IOException io) {
				io.printStackTrace();
				System.exit(-1);
			}

			String[] tokens = input.split("[ ]+");

			ArrayList<String> arguments = new ArrayList<String>();
			for (int i = 1; i < tokens.length; i++) {
				arguments.add(tokens[i]);
			}

			final String commandClassName = "ist.meic.pa.command.Command"
					+ tokens[0];
			Command cmd;
			try {
				cmd = (Command) Class.forName(commandClassName).newInstance();
				cmd.execute(arguments);
			} catch (ClassNotFoundException e) {
				System.err.println(tokens[0] + " : Inexisting command");
			} catch (InstantiationException e) {
				e.printStackTrace();
				System.exit(-1);
			} catch (IllegalAccessException e) {
				e.printStackTrace();
				System.exit(-1);
			}
		}
	}
}
