package ist.meic.pa.command;

import ist.meic.pa.DebuggerCLI;

import java.lang.reflect.Field;
import java.util.List;

public final class CommandInfo extends Command {
	@Override
	public void execute(List<String> args) {
		if (args.size() != 0) {
			printBadArgs();
			return;
		}
		
		Object receiver = DebuggerCLI.callStack.getCurrentReceiver();
		System.err
				.println("Called Object: "
						+ ((receiver == null) ? "(This is a static method)"
								: receiver));
		System.err.println(constructFieldString());
		System.err.println("Call stack:");
		System.err.println(DebuggerCLI.callStack);
	}

	private String constructFieldString() {
		String fieldsStr = "       Fields: ";

		if (DebuggerCLI.callStack.getCurrentMethod().getDeclaringClass()
				.getDeclaredFields().length == 0) {
			fieldsStr += "(This class has no fields)";
		} else {
			for (Field f : DebuggerCLI.callStack.getCurrentMethod()
					.getDeclaringClass().getDeclaredFields()) {
				fieldsStr += f.getName() + " ";
			}
			fieldsStr = fieldsStr.substring(0, fieldsStr.length() - 1);//removes last space
		}

		return fieldsStr;
	}
}