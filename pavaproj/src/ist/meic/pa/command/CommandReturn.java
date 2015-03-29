package ist.meic.pa.command;

import java.util.List;

import ist.meic.pa.DebuggerCLI;

public final class CommandReturn extends Command {
	@Override
	public void execute(List<String> args) {
		if (args.size() != 1) {
			printBadArgs();
			return;
		}
		
		String returnVal = args.get(0);
		DebuggerCLI.reading = false;
		Class<?> returnType = DebuggerCLI.callStack.getCurrentMethod()
				.getReturnType();

		if (returnType.equals(byte.class)) {
			DebuggerCLI.returnObject = Byte.parseByte(returnVal);
		} else if (returnType.equals(short.class)) {
			DebuggerCLI.returnObject = Short.parseShort(returnVal);
		} else if (returnType.equals(int.class) || returnType.equals(Integer.class)) {
			DebuggerCLI.returnObject = Integer.parseInt(returnVal);
		} else if (returnType.equals(long.class)) {
			DebuggerCLI.returnObject = Long.parseLong(returnVal);
		} else if (returnType.equals(float.class)) {
			DebuggerCLI.returnObject = Float.parseFloat(returnVal);
		} else if (returnType.equals(double.class)) {
			DebuggerCLI.returnObject = Double.parseDouble(returnVal);
		} else if (returnType.equals(char.class)) {
			DebuggerCLI.returnObject = returnVal.charAt(0);
		} else if (returnType.equals(boolean.class)) {
			DebuggerCLI.returnObject = Boolean.parseBoolean(returnVal);
		}

	}
}