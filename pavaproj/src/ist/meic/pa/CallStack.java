package ist.meic.pa;

import java.lang.reflect.Method;
import java.util.Stack;

public class CallStack {
	private class Call {
		Method method;
		Object receiver;
		Object[] arguments;

		Call(Method method, Object receiver, Object[] arguments) {
			this.method = method;
			this.receiver = receiver;
			this.arguments = arguments;
		}
	}

	private Stack<Call> st = new Stack<Call>();

	public void push(Method method, Object receiver, Object[] arguments) {
		st.push(new Call(method, receiver, arguments));
	}

	public void pop() {
		st.pop();
	}

	public Method getCurrentMethod() {
		return st.lastElement().method;
	}

	public Object getCurrentReceiver() {
		return st.lastElement().receiver;
	}

	public Object[] getCurrentArguments() {
		return st.lastElement().arguments;
	}

	@Override
	public String toString() {
		String s = "";

		for (int i = st.size() - 1; i >= 0; i--) {
			Call c = st.get(i);
			String[] split = c.method.toString().split("[ \\(]");
			s += split[split.length - 2];
			s += "(";
			for (Object arg : c.arguments) {
				s += arg + ",";
			}
			if (c.arguments.length > 0) {
				s = s.substring(0, s.length() - 1);
			}
			s += ")";
			s += "\n";
		}
		s = s.substring(0, s.length() - 1);

		return s;
	}

}