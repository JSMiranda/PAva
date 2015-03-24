package ist.meic.pa;

import java.io.IOException;

import javassist.*;

public class SampleLoader extends Loader {
	
	private static ClassPool pool = ClassPool.getDefault();
	
	public static void main(String[] args) throws Throwable {
		Loader javaLoader = new SampleLoader();
		Translator translator = new DebugTranslator();
		javaLoader.addTranslator(pool, translator);
		javaLoader.run(args);
	}


	/*
	 * Finds a specified class. The bytecode for that class can be modified.
	 */
	protected Class findClass(String name) throws ClassNotFoundException {
		try {
			CtClass cc = pool.get(name);
			// modify the CtClass object here
			byte[] b = cc.toBytecode();
			return defineClass(name, b, 0, b.length);
		} catch (NotFoundException e) {
			throw new ClassNotFoundException();
		} catch (IOException e) {
			throw new ClassNotFoundException();
		} catch (CannotCompileException e) {
			throw new ClassNotFoundException();
		}
	}
}