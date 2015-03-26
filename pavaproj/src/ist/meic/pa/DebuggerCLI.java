package ist.meic.pa;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Scanner;

import javassist.*;

public final class DebuggerCLI {

	private static ClassPool pool;
	static Throwable _t;

	public static void main(String[] args) throws Throwable {
		String[] test = { "test.Example" };
		if (args.length == 0)
			InjectCode(test);
		else
			InjectCode(args);
	}

	public static void InjectCode(String[] args) {
		try {

			Translator translator = new DebugTranslator();
			pool = ClassPool.getDefault();
			Loader classLoader = new Loader();
			classLoader.addTranslator(pool, translator);
			String[] restArgs = new String[args.length - 1];
			System.arraycopy(args, 1, restArgs, 0, restArgs.length);
			classLoader.run(args[0], restArgs);
		} catch (Throwable e) {
			e.printStackTrace();
		}

	}

	public static void test() {
		System.out.println("teste");
	}

	public static void execute(Object o, String methodName, Object[] args) {
		Class[] v = new Class[args.length];
		for (int i = 0; i < args.length; i++) {
			v[i] = args[i].getClass();
		}

		try {
			System.out.println("Calling method: " + methodName);
//			System.out.println("Receiver object: " + o);
//			System.out.println("Arguments: ");
//			for(Object ob : args) {
//				System.out.println(ob.getClass());
//			}
//			System.out.println("Methods: ");
//			for(Method m : o.getClass().getDeclaredMethods()) {
//				System.out.println(m);
//			}
			o.getClass().getMethod(methodName, v).invoke(o, args);
			System.out.println("Executed method: " + methodName);
		} catch (Exception e) {
			e.printStackTrace();
			// CheckInput(e);
		}
	}

	public static void CheckInput(Throwable t) {
		_t = t;
		Scanner s = new Scanner(System.in);
		CommandClass commandC = new CommandClass();

		while (true) {
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
				commandC.commandThrow();
				break;

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
