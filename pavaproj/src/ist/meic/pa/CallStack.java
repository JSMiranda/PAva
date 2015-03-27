package ist.meic.pa;

import java.lang.reflect.Method;
import java.util.Stack;

public class CallStack {
	private class Call {
		Method method;
		Object receiver;
		
		Call(Method m, Object r) {
			method = m;
			receiver = r;
		}
	}
	
	private Stack<Call> st = new Stack<Call>();
	
	
	public void push(Method method, Object receiver) {
		st.push(new Call(method, receiver));
	}
	
	public void pop() {
		st.pop();
	}
	
	public Method getCurrentMethod() {
		return st.firstElement().method;
	}

	public Object getCurrentReceiver() {
		return st.firstElement().receiver;
	}
	
}