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
			final Class<?> type = f.getType();
			if (type.equals(byte.class) || type.equals(Byte.class)) {
				f.set(DebuggerCLI.callStack.getCurrentReceiver(), Byte.parseByte(value));
			} else if (type.equals(short.class) || type.equals(Short.class)) {
				f.set(DebuggerCLI.callStack.getCurrentReceiver(), Short.parseShort(value));
			} else if (type.equals(int.class) || type.equals(Integer.class)) {
				f.set(DebuggerCLI.callStack.getCurrentReceiver(), Integer.parseInt(value));
			} else if (type.equals(long.class) || type.equals(Long.class)) {
				f.set(DebuggerCLI.callStack.getCurrentReceiver(), Long.parseLong(value));
			} else if (type.equals(float.class) || type.equals(Float.class)) {
				f.set(DebuggerCLI.callStack.getCurrentReceiver(), Float.parseFloat(value));
			} else if (type.equals(double.class) || type.equals(Double.class)) {
				f.set(DebuggerCLI.callStack.getCurrentReceiver(), Double.parseDouble(value));
			} else if (type.equals(char.class)) {
				f.set(DebuggerCLI.callStack.getCurrentReceiver(), value.charAt(0));
			} else if (type.equals(boolean.class) || type.equals(Boolean.class)) {
				f.set(DebuggerCLI.callStack.getCurrentReceiver(), Boolean.parseBoolean(value));
			}
		} catch (NoSuchFieldException e) {
			System.err.println("No such Field. Try again.");
		} catch (IllegalAccessException e) {
			System.err.println("Invalid set: " + e.getMessage());
		}
	}
}