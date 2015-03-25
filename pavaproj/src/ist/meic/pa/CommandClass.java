package ist.meic.pa;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Scanner;

import javassist.*;

public class CommandClass {
	static Throwable _t;
	public static void test(){
		System.out.println("estou ca");
	}
	
	public static void execute(Object o, String methodName, Object[] args){
		
	    Class[] v= new Class[args.length];
	    for(int i=0;i<args.length;i++){
	        v[i]=args[i].getClass();
	    }
	    
		try{
			System.out.println("estou caa");
			o.getClass().getMethod(methodName, v).invoke(args);
			System.out.println("vou sair");
		}catch(Exception e){
		e.printStackTrace();
		  //  CheckInput(e);
		
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

	private void commandAbort() {
		System.exit(0);
	}

	private void commandInfo() {
		// TODO
	}

	private void commandThrow() {
	  //  throw t;
		
	}

	private void commandReturn(Object o) {
		// TODO
	}

	private void commandGet(String s) {
		System.out.println("sup niggas" + s);
	}

	private void commandSet(String s, Object o) {
		// TODO
	}

	private void commandRetry() {
		// TODO
	}

}
