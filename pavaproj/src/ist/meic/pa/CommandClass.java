package ist.meic.pa;

public class CommandClass {

	protected void commandAbort() {
		System.exit(0);
	}

	protected void commandInfo() {
		// TODO
		System.out.println("....... Info cenas");
	}

	protected void commandReturn(String s) {
		// TODO
		DebuggerCLI.reading = false;

		System.out.println("Class: " + DebuggerCLI.returnType);
		
		if(DebuggerCLI.returnType.equals(Integer.class)) {
			DebuggerCLI.returnObject = Integer.parseInt(s);
		}
		if(DebuggerCLI.returnType.equals(Double.class)) {
			DebuggerCLI.returnObject = Double.parseDouble(s);
		}
		// TODO: other types ...
	}

	protected void commandGet(String s) {
		// TODO
		System.out.println("....... Get cenas");
	}

	protected void commandSet(String s, Object o) {
		// TODO
		System.out.println("....... Set cenas");
	}

	protected void commandRetry() {
		DebuggerCLI.reading = false;
		DebuggerCLI.retrying = true;
	}

}
