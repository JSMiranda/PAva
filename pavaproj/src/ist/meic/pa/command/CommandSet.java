package ist.meic.pa.command;

import ist.meic.pa.DebuggerCLI;

import java.lang.reflect.Field;
import java.util.List;

public final class CommandSet extends Command {
	@Override
	public void execute(List<String> args) {
		if (args.size() != 2) {
			printBadArgs();
			return;
		}
		
		String fieldName = args.get(0);
		String value = args.get(1);
		try {
			Field f = DebuggerCLI.callStack.getCurrentMethod().getDeclaringClass().getDeclaredField(fieldName);
			f.setAccessible(true);
			if (f.getType().equals(byte.class)) {
				f.set(DebuggerCLI.callStack.getCurrentReceiver(), Byte.parseByte(value));
			} else if (f.getType().equals(short.class)) {
				f.set(DebuggerCLI.callStack.getCurrentReceiver(), Short.parseShort(value));
			} else if (f.getType().equals(int.class)) {
				f.set(DebuggerCLI.callStack.getCurrentReceiver(), Integer.parseInt(value));
			} else if (f.getType().equals(long.class)) {
				f.set(DebuggerCLI.callStack.getCurrentReceiver(), Long.parseLong(value));
			} else if (f.getType().equals(float.class)) {
				f.set(DebuggerCLI.callStack.getCurrentReceiver(), Float.parseFloat(value));
			} else if (f.getType().equals(double.class)) {
				f.set(DebuggerCLI.callStack.getCurrentReceiver(), Double.parseDouble(value));
			} else if (f.getType().equals(char.class)) {
				f.set(DebuggerCLI.callStack.getCurrentReceiver(), value.charAt(0));
			} else if (f.getType().equals(boolean.class)) {
				f.set(DebuggerCLI.callStack.getCurrentReceiver(), Boolean.parseBoolean(value));
			}
		} catch (NoSuchFieldException e) {
			System.err.println("No such Field. Try again.");
		} catch (IllegalAccessException e) {
			System.err.println("Invalid set: " + e.getMessage());
		}
	}
}