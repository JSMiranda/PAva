package ist.meic.pa;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Scanner;

import javassist.ClassPool;
import javassist.Loader;
import javassist.Translator;

public final class DebuggerCLI {
	public static boolean retrying; // TODO: check a better way
	public static boolean reading; // TODO: check a better way
	public static Object returnObject; // TODO: check a better way
	public static CallStack callStack = new CallStack(); // TODO: check a better way

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
			rtClass.getDeclaredMethod("mainehajekd39203", new Class[] { String[].class })
					.invoke(null, new Object[] { restArgs });
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public static void test() {
		System.out.println("teste");
	}

	public static Object execute(String className, String methodName, Object o,
			Object[] args) throws Throwable {
		
		retrying = false;
		returnObject = null;
		do {
			try {
				Class<?> originalClass = Class.forName(className);
				Class<?>[] argsClasses = new Class<?>[args.length];
				for (int i = 0; i < args.length; i++) {
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

				Method m = originalClass.getMethod(methodName, argsClasses);
				m.setAccessible(true);
				callStack.push(m, o, args);
				returnObject = m.invoke(originalClass.cast(o), args);
			} catch (InvocationTargetException e) {
				System.out.println(e.getCause());
				CheckInput(e.getCause());
			}
			callStack.pop();
		} while (retrying);
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
				System.out.println("Invalid command");
				break;
			}
		}
	}
}
