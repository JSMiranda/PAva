package ist.meic.pa;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Scanner;

import javassist.CannotCompileException;
import javassist.ClassPool;
import javassist.Loader;
import javassist.NotFoundException;
import javassist.Translator;

public final class DebuggerCLI {
	public static boolean retrying; // TODO: check a better way
	public static boolean reading; // TODO: check a better way
	public static Object returnObject; // TODO: check a better way
	public static Class<?> returnType; // TODO: check a better way

	private static ClassPool pool = ClassPool.getDefault();
	static Throwable _t;

	public static void main(String[] args) {
		String[] test = { "test.Example" };
		if (args.length == 0)
			InjectCode(test);
		else
			InjectCode(args);
	}

	public static void InjectCode(String[] args) {
		try {

			Loader javaLoader = new Loader(pool);
			Translator translator = new DebugTranslator();
			javaLoader.addTranslator(pool, translator);
			String[] restArgs = new String[args.length - 1];
			System.arraycopy(args, 1, restArgs, 0, restArgs.length);
			Class<?> rtClass = javaLoader.loadClass(args[0]);
			rtClass.getDeclaredMethod("main", new Class[] { String[].class })
					.invoke(null, new Object[] { restArgs });
			// javaLoader.run(file);

		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CannotCompileException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			System.out.println("targetexception");
			e.printStackTrace();
		}

	}

	public static void test() {
		System.out.println("teste");
	}

	public static Object execute(String className, String methodName, Object o,
			Object[] args) throws Throwable {
		
		retrying = false;
		returnType = null;
		returnObject = null;
		do {
			try {
				Class<?> originalClass = Class.forName(className);
				Class<?>[] v = new Class<?>[args.length];
				for (int i = 0; i < args.length; i++) {
					v[i] = args[i].getClass();
					if (v[i].getName().equals("java.lang.Byte"))
						v[i] = byte.class;
					if (v[i].getName().equals("java.lang.Short"))
						v[i] = short.class;
					if (v[i].getName().equals("java.lang.Integer"))
						v[i] = int.class;
					if (v[i].getName().equals("java.lang.Long"))
						v[i] = long.class;
					if (v[i].getName().equals("java.lang.Float"))
						v[i] = float.class;
					if (v[i].getName().equals("java.lang.Double"))
						v[i] = double.class;
					if (v[i].getName().equals("java.lang.Character"))
						v[i] = char.class;
					if (v[i].getName().equals("java.lang.Boolean"))
						v[i] = boolean.class;
				}

				// System.out.println("Calling method: " + methodName);
				Method m = originalClass.getMethod(methodName, v);
				m.setAccessible(true);
				returnType = m.getReturnType();
				System.out.println("woot " + methodName + " " + returnType);
				returnObject = m.invoke(originalClass.cast(o), args);
				System.out.println("Executed method: " + methodName);
			} catch (Exception e) {
				// System.out.println("upsi");
				// e.printStackTrace();
				//if(e.getCause().getClass().equals(NullPointerException.class))
				//	e.printStackTrace();
				System.out.println(e.getCause());
				CheckInput(e.getCause());
			}
		} while (retrying);
		System.out.println("Will I crash? " + methodName);
		return returnObject;
	}

	public static void CheckInput(Throwable t) throws Throwable {
		_t = t;
		Scanner s = new Scanner(System.in);
		CommandClass commandC = new CommandClass();

		reading = true;
		while (reading) {
			System.out.print("DebuggerCLI:> ");
			String arg = s.nextLine();
			String[] tokens = arg.split("[ ]+");

			ArrayList<String> arguments = new ArrayList<String>();
			for (int i = 1; i < tokens.length; i++) {
				arguments.add(tokens[i]);
			}
			// CommandClass.class.getMethod(tokens[0]).invoke(commandC, "oi");
			switch (tokens[0]) {

			case "Abort":
				commandC.commandAbort();
				break;

			case "Info":
				commandC.commandInfo();
				break;

			case "Throw":
				throw _t;

			case "Return":
				commandC.commandReturn(tokens[1]);
				break;

			case "Get":
				commandC.commandGet(tokens[1]);
				break;

			case "Set":
				commandC.commandSet(tokens[1], tokens[2]);
				break;

			case "Retry":
				commandC.commandRetry();
				break;

			default:
				System.out.println("Syke thats the wrong command");
				break;

			}
		}
	}
}
