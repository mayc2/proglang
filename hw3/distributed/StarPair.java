package concurrent;

import java.util.*;
import java.io.*;

public class StarPair implements Serializable{
	public Star a, b;

	public StarPair(Star a1, Star b1){
		a=a1;
		b=b1;
	}

	public Star getS1(){
		return a;
	}

	public Star getS2(){
		return b;
	}

	public String toString() {
		double x1, x2, y1, y2, z1, z2;
		x1 = a.getX();
		x2 = b.getX();
		y1 = a.getY();
		y2 = b.getY();
		z1 = a.getZ();
		z2 = b.getZ();
		return "(" + x1 + ", " + y1 + ", " + z1 + ")   (" + x2 + ", " + y1 + ", " + z1 + ")";
	}
};