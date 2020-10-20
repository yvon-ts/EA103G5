package com.lecseat.controller;

import java.util.ArrayList;

public class tst {
	public static void main(String[] args) {
		
		String lodrseat = "00111***1111";
		
		if (lodrseat.indexOf("2") != -1) {
			lodrseat = lodrseat.replace("2", "1");
			if (lodrseat.indexOf("*") != -1) {
				lodrseat = lodrseat.replace("*", "2");
			}
		} else if (lodrseat.indexOf("*") != -1) {
			lodrseat = lodrseat.replace("*", "2");
		}
			System.out.println("transfomed lodreat = " + lodrseat);
		
	}
}
