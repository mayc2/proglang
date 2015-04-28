package concurrent;

import java.util.*;
import java.io.*;

public class Star{
	public double x,y,z;

	public Star(double a, double b, double c){
		x=a;
		y=b;
		z=c;
	}

	public Vector get(){
		Vector ans = new Vector();
		ans.add(x);
		ans.add(y);
		ans.add(z);
		return ans;
	}

	private double getX(){return x;}
	private double getY(){return y;}
	private double getZ(){return z;}

	public double getDiff(double val1, double val2) {
		return val1-val2;
	}

	public double distance(Star other){
		double x_val = getDiff(other.getX(),x);
		double y_val = getDiff(other.getY(),y);
		double z_val = getDiff(other.getZ(),z);

		return Math.sqrt((x_val*x_val)+(y_val*y_val)+(z_val*z_val));
	}

	public String toString() {
		return "(" + x + ", " + y + ", " + z + ")";
	}
};