package ist.meic.pa.command;

import ist.meic.pa.DebuggerCLI;

import java.lang.reflect.Field;
import java.util.List;

public final class CommandGet extends Command {
	@Override
	public void execute(List<String> args) {
		if (args.size() != 1) {
			printBadArgs();
			return;
		}
		
		String fieldName = args.get(0);
		try {
			Field f = DebuggerCLI.callStack.getCurrentMethod().getDeclaringClass().getDeclaredField(fieldName);
			f.setAccessible(true);
			System.err.println(f.get(DebuggerCLI.callStack.getCurrentReceiver()));
		} catch (NoSuchFieldException e) {
			System.err.println("No such Field. Try again.");
		} catch (Exception e) {
			e.printStackTrace();
			System.exit(-1);
		}
	}
}