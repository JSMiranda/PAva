package ist.meic.pa;

import javassist.*;
import javassist.expr.ExprEditor;
import javassist.expr.MethodCall;

public class DebugTranslator implements Translator {

	@Override
	public void onLoad(ClassPool pool, String className)
			throws NotFoundException, CannotCompileException {
		// TODO Auto-generated method stub
		CtClass ctClass = pool.get(className);
		modifyMethods(ctClass);

	}

	private void modifyMethods(CtClass ctClass) throws CannotCompileException {
		for (CtMethod cm : ctClass.getDeclaredMethods()) {
			if(!ctClass.getName().equals("ist.meic.pa.CommandClass")){
					cm.instrument(new ExprEditor() {
						public void edit(MethodCall m) throws CannotCompileException {
						        System.out.println(m.getMethodName());
								m.replace("{ist.meic.pa.CommandClass.execute($0, \""+ m.getMethodName()+"\", $args);$_ = $proceed($$);}");
						}
					});
			}
		}
	}

	@Override
	public void start(ClassPool arg0) throws NotFoundException,
			CannotCompileException {
		// TODO Auto-generated method stub
	}

}
