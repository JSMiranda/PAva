package ist.meic.pa.command;

import ist.meic.pa.DebuggerCLI;

import java.util.List;

public final class CommandThrow extends Command {
	@Override
	public void execute(List<String> args) {
		DebuggerCLI.reading = false;
		DebuggerCLI.throwing = true;
	}
}