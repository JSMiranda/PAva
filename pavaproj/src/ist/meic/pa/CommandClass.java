package ist.meic.pa;

import java.lang.reflect.Field;

public class CommandClass {

	protected void commandAbort() {
		System.out.println("Aborting.");
		System.exit(0);
	}

	protected void commandInfo() {
		Object receiver = DebuggerCLI.callStack.getCurrentReceiver();
		System.out
				.println("Called Object: "
						+ ((receiver == null) ? "(This is a static method)"
								: receiver));
		System.out.println(constructFieldString());
		System.out.println("Call stack:");
		System.out.println(DebuggerCLI.callStack);
	}

	private String constructFieldString() {
		String fieldsStr = "       Fields: ";
		
		if (DebuggerCLI.callStack.getCurrentMethod().getDeclaringClass()
				.getDeclaredFields().length == 0) {
			fieldsStr += "(This class has no fields)";
		} else {
			for (Field f : DebuggerCLI.callStack.getCurrentMethod()
					.getDeclaringClass().getDeclaredFields()) {
				fieldsStr += f.getName() + ",";
			}
			fieldsStr = fieldsStr.substring(0, fieldsStr.length() - 1);
		}
		
		return fieldsStr;
	}

	protected void commandReturn(String s) {
		DebuggerCLI.reading = false;
		Class<?> returnType = DebuggerCLI.callStack.getCurrentMethod()
				.getReturnType();

		if (returnType.equals(byte.class)) {
			DebuggerCLI.returnObject = Byte.parseByte(s);
		} else if (returnType.equals(short.class)) {
			DebuggerCLI.returnObject = Short.parseShort(s);
		} else if (returnType.equals(int.class)) {
			DebuggerCLI.returnObject = Integer.parseInt(s);
		} else if (returnType.equals(long.class)) {
			DebuggerCLI.returnObject = Long.parseLong(s);
		} else if (returnType.equals(float.class)) {
			DebuggerCLI.returnObject = Float.parseFloat(s);
		} else if (returnType.equals(double.class)) {
			DebuggerCLI.returnObject = Double.parseDouble(s);
		} else if (returnType.equals(char.class)) {
			DebuggerCLI.returnObject = s.charAt(0);
		} else if (returnType.equals(boolean.class)) {
			DebuggerCLI.returnObject = Boolean.parseBoolean(s);
		}
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
