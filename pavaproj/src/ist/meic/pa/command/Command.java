package ist.meic.pa.command;

import java.util.List;


public abstract class Command {
	public abstract void execute(List<String> args);
	protected void printBadArgs() {
		System.err.println("Bad syntax for " + this.getClass().getSimpleName());
	}
}
