package ist.meic.pa;

import java.util.ArrayList;
import java.util.Scanner;

import javassist.*;

public final class DebuggerCli {
	
	private static ClassPool pool = ClassPool.getDefault();

	public static void main(String[] args) throws Throwable {
		String[] test = {"test.Example"};
		if(args.length == 0)
			InjectCode(test);
		else
			InjectCode(test);
	}
	
	public static void InjectCode(String[] file) throws Throwable{
		pool.importPackage("ist.meic.pa");
		Loader javaLoader = new Loader(pool);
		Translator translator = new DebugTranslator();
		javaLoader.addTranslator(pool, translator);
		javaLoader.run(file);
	}
}
