package ist.meic.pa;

import javassist.*;
import javassist.expr.ExprEditor;
import javassist.expr.MethodCall;

public class DebugTranslator implements Translator {

	@Override
	public void onLoad(ClassPool pool, String className)
			throws NotFoundException, CannotCompileException {
		// TODO Auto-generated method stub
		String[] split = className.split("\\.");
		String first = split[0];
		String last = split[split.length - 1];
		if (!first.equals("javassist") && !last.equals("DebuggerCLI") && !last.equals("CommandClass") && !last.equals("CallStack")) {
			//System.out.println("Instrumenting methods of class " + className);
			CtClass ctClass = pool.get(className);
			modifyMethods(ctClass);
		}

	}

	private void modifyMethods(final CtClass ctClass)
			throws CannotCompileException {
		for (CtMethod cm : ctClass.getDeclaredMethods()) {
			cm.instrument(new ExprEditor() {
				public void edit(MethodCall m) throws CannotCompileException {
					//System.out.println("       INSTRUMENTED METHOD: "+ m.getMethodName());
					// m.replace("{ist.meic.pa.DebuggerCLI.test(); $_ = $proceed($$);}");
					m.replace("{$_ = ($r) ist.meic.pa.DebuggerCLI.execute(\""+m.getClassName()+"\", \""+ m.getMethodName()+ "\",$0 , $args);}");
				}
			});
		}
	}

	@Override
	public void start(ClassPool arg0) throws NotFoundException,
			CannotCompileException {
		// TODO Auto-generated method stub
	}

}
