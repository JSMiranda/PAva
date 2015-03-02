package lab01;

import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner s = new Scanner(System.in);

		while (true) {
			try {
				String classString = s.next();
				Class<?> myClass = Class.forName(classString);
				Message instance = (Message) myClass.newInstance();
				instance.say();
				break;
			} catch (ClassNotFoundException e) {
				String classNotFoundStr = "The class you are trying to use does not exist. Please retry.";
				System.out.println(classNotFoundStr);
			} catch (Exception e) {
				e.printStackTrace();
				System.exit(-1);
			}
		}
		s.close();
	}

}
