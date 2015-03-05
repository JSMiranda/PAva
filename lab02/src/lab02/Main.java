package lab02;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Main {

	public static void main(String[] args) {

		Scanner s = new Scanner(System.in);
		String arg;

		List<String> classStrings = new ArrayList<String>();
		List<Class> classArray = new ArrayList<Class>();
		
		while (true) {

			arg = s.nextLine();
			String[] tokens = arg.split("[ ]+");

			switch (tokens[0]) {

			case "Class":

				Class<?> c;
				try {
					c = Class.forName(tokens[1]);
					classArray.add(c);
					classStrings.add(tokens[1]);
					System.out.println(c.toString());

				} catch (ClassNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				break;
				
			case "Set":
				classStrings.set(classStrings.size() - 1, tokens[1]);
				break;
				
			case "Get":
				for (int i = classArray.size() - 1; i >= 0; i--) {

					if (classStrings.get(i).equals(tokens[1])) {
						System.out.println(classArray.get(i).toString());
						break;
					}
				}
				break;
				
			case "Index":
				System.out.println(classArray.get(Integer.parseInt(tokens[1])).toString());
				
				break;
				
			default:
				System.out.println("Wrong Command");
				break;

			}

		}
	}
}
