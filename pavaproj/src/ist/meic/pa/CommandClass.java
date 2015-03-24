package ist.meic.pa;

import java.util.ArrayList;
import java.util.Scanner;

public class CommandClass {
	
public static void CheckInput(){
		
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
				System.out.println("Syke thats the wrong command");
				break;
				
			}
		}
	}

	private void commandAbort(){
		System.out.println("sup bitches");
	}
	
	private void commandInfo(){
		//TODO
	}
	
	private void commandThrow(){
		//TODO
	}
	
	private void commandReturn(Object o){
		//TODO
	}
	private void commandGet(String s){
		System.out.println("sup niggas" + s);
	}
	private void commandSet(String s,Object o){
		//TODO
	}
	private void commandRetry(){
		//TODO
	}
	
}
