package ist.meic.pa;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Scanner;

import javassist.*;

public final class DebuggerCLI {

	private static ClassPool pool = ClassPool.getDefault();
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

			Loader javaLoader = new Loader(pool);
			Translator translator = new DebugTranslator();
			javaLoader.addTranslator(pool, translator);
			String[] restArgs = new String[args.length - 1];
			Class<?> rtClass = javaLoader.loadClass(args[0]);
			rtClass.getDeclaredMethod("main", new Class[] { String[].class }).invoke(null, new Object[] {restArgs});
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

	public static void execute(Object o, String methodName, Object[] args) {

		Class[] v = new Class[args.length];
		for (int i = 0; i < args.length; i++) {
			v[i] = args[i].getClass();
		}

		try {
			System.out.println("estou ca");
			o.getClass().getMethod(methodName, v).invoke(args);
			System.out.println("vou sair");
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
