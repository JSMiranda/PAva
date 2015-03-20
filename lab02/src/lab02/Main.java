package lab02;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		
		System.out.flush();
		Scanner s = new Scanner(System.in);
		String arg;
		
		Object selectedObject = null;
		Hashtable<String, Object> table = new Hashtable<String, Object>();
		//Object results = null;
		Object results;
		while (true) {
			arg = s.nextLine();
			String[] tokens = arg.split("[ ]+");
			ArrayList<String> arguments = new ArrayList<String>();
			for(int i = 1;i<tokens.length;i++){
				arguments.add(tokens[i]);
			}
			switch (tokens[0]) {
			case "Class":
				Class<?> c;
				try {
					c = Class.forName(tokens[1]);
					table.put(tokens[1], c);
					selectedObject = c;
					System.out.println(c.toString());
				} catch (ClassNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				break;
			case "Set":
				table.put(tokens[1], selectedObject);
				System.out.println("Saved name for object of type: " + selectedObject.getClass().toString());
				System.out.println(selectedObject.toString());
				break;
			case "Get":
				Object o = table.get(tokens[1]);
				System.out.println(o.toString());
				break;
			case "Index":
					Object[] array = (Object[])selectedObject;
					selectedObject = array[Integer.parseInt(tokens[1])];
					String print = selectedObject.toString();
					System.out.println(print);
				break;
			default:
				try {
					System.out.println("Trying generic command: " + arg);
					Class<?> input[] = new Class[arguments.size()];
				    for (int i = 0; i < arguments.size(); i++) {
				        input[i] = arguments.get(i).getClass();
				    }
					if(arguments.isEmpty()){
						Method m = selectedObject.getClass().getMethod(tokens[0], null);
						results = m.invoke(selectedObject, null);
						selectedObject = results;
					}
					else {
						Method m = selectedObject.getClass().getMethod(tokens[0], input);
						results = m.invoke(selectedObject, arguments);
						selectedObject = results;
					}
					for(Object o2 : (Object[])results)
						System.out.println(o2.toString());
				} catch (NoSuchMethodException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (SecurityException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IllegalArgumentException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (InvocationTargetException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} 
				break;
			}
		}
	}
	
	static Method bestMethod(Class<?> type, String name, Class<?> argType ) throws	NoSuchMethodException{
		try {
			System.out.println(type.toString());
			return	type.getMethod(name, argType);
		}
		catch(NoSuchMethodException	e) {
			if(argType == Object.class) {
				throw	new	NoSuchMethodException(name);
			}
			else {
				return	bestMethod(type, name, argType.getSuperclass());
			}
		}
	}
