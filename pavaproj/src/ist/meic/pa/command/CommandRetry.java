package ist.meic.pa.command;

import ist.meic.pa.DebuggerCLI;

import java.util.List;

public final class CommandRetry extends Command {
	@Override
	public void execute(List<String> args) {
		if (args.size() != 0) {
			printBadArgs();
			return;
		}
		
		DebuggerCLI.reading = false;
		DebuggerCLI.retrying = true;
	}
}