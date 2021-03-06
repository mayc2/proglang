package concurrent;

import java.util.*;
import java.io.*;

public class Star implements Serializable{
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

	public double getX(){return x;}
	public double getY(){return y;}
	public double getZ(){return z;}

	public double distance(Star other){
		double x_val = other.getX() - x;
		double y_val = other.getY() - y;
		double z_val = other.getZ() - z;

		return Math.sqrt((x_val*x_val)+(y_val*y_val)+(z_val*z_val));
	}

	public String toString() {
		return "(" + x + ", " + y + ", " + z + ")";
	}
};