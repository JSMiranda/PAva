package ist.meic.pa;

import javassist.*;

public final class DebuggerCLI {
	
	private static ClassPool pool = ClassPool.getDefault();

	public static void main(String[] args) throws Throwable {
		String[] test = {"test.Example"};
		if(args.length == 0)
			InjectCode(test);
		else
			InjectCode(args);
	}
	
	public static void InjectCode(String[] file) throws Throwable{
		Loader javaLoader = new Loader(pool);
		Translator translator = new DebugTranslator();
		javaLoader.addTranslator(pool, translator);
		/*Class<?> rtClass = javaLoader.loadClass(file[0]);
		rtClass.getDeclaredMethod("main", new Class[] { String[].class })
        .invoke(null, new Object[] { file});*/
		javaLoader.run(file);
	}
}
