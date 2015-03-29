package ist.meic.pa;

import javassist.*;
import javassist.expr.ExprEditor;
import javassist.expr.MethodCall;

public class DebugTranslator implements Translator {

	@Override
	public void onLoad(ClassPool pool, String className)
			throws NotFoundException, CannotCompileException {
		final boolean isJavassistClass = className.contains("javassist");
		final boolean isDebuggerClass = className.contains("ist.meic.pa");
		if (!isJavassistClass && !isDebuggerClass) {
			CtClass ctClass = pool.get(className);
			modifyMethods(ctClass);
		}
	}

	private void modifyMethods(final CtClass ctClass)
			throws CannotCompileException {
		try {
			CtMethod[] classMethods = ctClass.getDeclaredMethods("main");
			if (classMethods.length > 0) {
				CtMethod cm = classMethods[0];
				CtMethod newcm = CtNewMethod.copy(cm, cm.getName() + "ehajekd39203", ctClass,
						null);
				ctClass.addMethod(newcm);
				newcm.setBody("{" + cm.getName() + "($$);}");
			}
		} catch (NotFoundException e) {
			e.printStackTrace();
		}

		for (CtMethod cm : ctClass.getDeclaredMethods()) {
			cm.instrument(new ExprEditor() {
				public void edit(MethodCall m) throws CannotCompileException {
					m.replace("{$_ = ($r) ist.meic.pa.DebuggerCLI.execute(\""
							+ m.getClassName() + "\", \"" + m.getMethodName()
							+ "\",$0 , $args);}");
				}
			});
		}
	}

	@Override
	public void start(ClassPool arg0) throws NotFoundException,
			CannotCompileException {
		// Empty method
	}

}
