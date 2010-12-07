package com.L910;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;

public class Main {

	/**
	 * @param args
	 * @throws Exception 
	 */
	public static void main(String[] args) throws Exception {
		File file = new File(args[0]);
		InputStream is = new FileInputStream(file);
		new parser(new Lexer(is)).parse();
		System.out.println("Parser: OK");

	}

}
