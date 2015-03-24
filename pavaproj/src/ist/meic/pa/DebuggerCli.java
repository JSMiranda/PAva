package ist.meic.pa;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Scanner;
import javassist.*;

public class DebuggerCli {

	public static void main(String[] args) throws Throwable {

		//SampleLoader.main(args);

		Scanner s = new Scanner(System.in);
		CommandClass commandC = new CommandClass();

		while (true) {
			String arg = s.nextLine();
			String[] tokens = arg.split("[ ]+");

			ArrayList<String> arguments = new ArrayList<String>();
			for(int i = 1;i<tokens.length;i++){
				arguments.add(tokens[i]);
			}
			//CommandClass.class.getMethod(tokens[0]).invoke(commandC, "oi");
			switch(tokens[0]){

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
				System.out.println("syke thats the wrong command");
				break;
			
			
			}
		}
	}
}
