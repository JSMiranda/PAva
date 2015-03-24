package ist.meic.pa;

import javassist.*;

public class DebugTranslator implements Translator {

	@Override
	public void onLoad(ClassPool pool, String className) throws NotFoundException, CannotCompileException {
		// TODO Auto-generated method stub
		CtClass ctClass = pool.get(className);
		modifyMethods(ctClass);

	}

	private void modifyMethods(CtClass ctClass) {
		for(CtMethod m: ctClass.getDeclaredMethods()){
			try {
			 	CtClass etype;
				etype = ClassPool.getDefault().get("java.lang.Exception");
				m.addCatch("{CommandClass.CheckInput(); throw $e;}", etype);
			} catch (NotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CannotCompileException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	}

	@Override
	public void start(ClassPool arg0) throws NotFoundException,
			CannotCompileException {
		// TODO Auto-generated method stub
	}

}
