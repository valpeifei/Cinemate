package assignment2;

import java.io.InputStream;
import java.util.Scanner;

public class ParseConfig {
	
	public String[] parse(){
		String[] config = new String[4];
		InputStream is = getClass().getClassLoader().getResourceAsStream("rsrc/config.txt");
		//File scanner
		Scanner reader = new Scanner(is);
		System.out.println("here");
		while (reader.hasNext()) {
			String curr = reader.next();
 
			if (curr.startsWith("ipaddress")){
				 
				String[] parts = curr.split(":");
				config[0] = parts[1];
				 
			}
			else if (curr.startsWith("db")){
				 
				String[] parts = curr.split(":");
				config[1] = parts[1];
				 
			}
			else if (curr.startsWith("user")){
				String[] parts = curr.split(":");
				config[2] = parts[1];
				 
			}
			else if (curr.startsWith("password")){
				String[] parts = curr.split(":");
				config[3] = parts[1];
				 
			}
		}
		return config;
	}
}
