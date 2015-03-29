package ist.meic.pa.command;

import java.util.List;

public final class CommandAbort extends Command {
	@Override
	public void execute(List<String> args) {
		if (args.size() != 0) {
			printBadArgs();
			return;
		}
		
		System.err.println("Aborting.");
		System.exit(0);
	}
}