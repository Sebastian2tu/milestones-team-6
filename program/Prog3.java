import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/*
 *Evan Lee
 *CSC 345 - Spring 2019
 *Prog 3 - ColumnSort 
 * 
 */
public class Prog3 {
	
	public static void main(String[] args) {
		String fileLocation = args[0];
		Integer[] numbers = readFile(fileLocation);
		int[] dimensions = findDimensions(numbers.length);
		Integer[][]matrix = toMatrix(numbers,dimensions[0],dimensions[1]);
		//System.out.println(matrixToString(matrix));
		
		System.out.println("n = " + numbers.length);
		System.out.println("r = " + dimensions[0]);
		System.out.println("s = " + dimensions[1]);
		
		long time1 = System.nanoTime();
		//ColumnsSort------------------------------------
		//step 1 sort
		sortColumns(matrix);
		//step 2 transpose and reshape
		matrix = transpose(matrix);
		matrix = reshape (matrix);
		//step 3 sort
		sortColumns(matrix);
		//step 4 reshape and transpose
		matrix = reshapeInverse(matrix);
		matrix = transpose(matrix);
		//step 5 sort
		sortColumns(matrix);
		//step 6 shift positions down r/2 positions
		matrix = shiftDownR2(matrix);
		//step 7 sort
		sortColumns(matrix);
		//step 8 shift up by r/2 positions
		matrix = shiftUpR2(matrix);
		//End of ColumnSort---------------------------------------
		long time2 = System.nanoTime();
		double seconds = (time1-time2)/1000000000;
		
		System.out.printf("Elapsed time = %.3f seconds\n",seconds);
		//print out result
		for (Integer i: toOneDimByCol(matrix)) {
			System.out.println(i);
		}
		
	}
	
	private static String matrixToString(Integer[][] matrix) {
		String result = "";
		for (int i = 0; i < matrix.length; i++) {
			for (int j = 0; j < matrix[0].length;j++) {
				result += String.valueOf(matrix[i][j]) + " ";
			}
			result+="\n";
		}
		return result;
	}
//	
	/*
	 * Represents step 8 in the columnsort algorithm. Will 
	 * shift the entire matrix up by r/s spaces.
	 * Parameters: 2-d Array of integers of size RxS+1
	 * Returns: 2-d Array of integers of size RxS
	 */
	private static Integer[][] shiftUpR2(Integer[][] matrix){
		int r = matrix.length;
		int s = matrix[0].length;
		List<Integer> seq = toOneDimByCol(matrix);
		for (int i = 0; i < Math.floor(r/2); i++) {
			seq.remove((Integer)Integer.MIN_VALUE);
		}
		for (int i =0; i < Math.ceil(r/2);i++) {
			seq.remove((Integer)Integer.MAX_VALUE);
		}
		return matByCols(seq.toArray(new Integer[seq.size()]),r,s-1);
	}
	
	/*
	 * Represents step 6 in the columnsort algorithm. Will 
	 * shift the entire matrix by r/s spaces.
	 * Parameters: 2-d Array of integers of size RxS
	 * Returns: 2-d Array of integers of size RxS+1
	 */
	private static Integer[][] shiftDownR2(Integer[][] matrix){
		int r = matrix.length;
		int s = matrix[0].length;
		List<Integer> seq = toOneDimByCol(matrix);
		for (int i = 0; i < Math.floor(r/2); i++) {
			seq.add(0,Integer.MIN_VALUE);
		}
		for (int i =0; i < Math.ceil(r/2);i++) {
			seq.add(Integer.MAX_VALUE);
		}
		return matByCols(seq.toArray(new Integer[seq.size()]),r,s+1);
	}
	
	/*
	 * Similar to toOneDim, this function converts a 2-d array of integers
	 * into a 1-d array of integers, where the integers are in column-major order
	 * Parameters: 2-d array of integers
	 * Returns: 1-d array of integers
	 */
	private static List<Integer> toOneDimByCol(Integer[][]matrix){
		List<Integer> list = new ArrayList<>();
		for (int j = 0; j < matrix[0].length;j++) {
			for (int i = 0; i < matrix.length; i++) {
				list.add(matrix[i][j]);
			}
		}
		return list;
	}
	
	/*
	 * Converts a 1-d array of integers into a 2-d array. Similar to
	 * toMatrix, though this function places the digits in row-first order.
	 * I.e. [a,b,c,d,e,f] 2 3 returns [[a,c,e][b,d,f]]
	 * Parameters: an array of integers, int row, int cols
	 * Returns a 2-D array of integers
	 * 
	 */
	private static Integer[][] matByCols(Integer[] nums, int r, int s){
		Integer[][] result = new Integer[r][s];
		for (int index =0; index <nums.length; index++) {
			int val = nums[index];
			int col = index/r;
			int row = index%r;
			result[row][col]=val;
		}
		return result;
		
	}
	/*
	 * Converts a 2-D array of integers into a 1-D array of integers
	 * The 1-d array of integers is placed in row-major order.
	 * Parameters: 2-d array of integers
	 * Returns: 1-d array of integers
	 */
	private static List<Integer> toOneDim(Integer[][] matrix) {
		List<Integer> list = new ArrayList<>();
		for (int i = 0; i < matrix.length; i++) {
			for (int j = 0; j < matrix[0].length;j++) {
				list.add(matrix[i][j]);
			}
		}
		return list;
	}
	
	/*
	 * Sorts each column of the matrix via mergesort in-place.
	 * Parameters: a 2-D matrix
	 * Modifies the array in place
	 */
	private static void sortColumns(Integer[][] matrix){
		int r = matrix.length;
		int s = matrix[0].length;
		Integer[] toSort = new Integer[r];
		for (int col =0; col < s; col++) {
			for (int row = 0; row < r; row ++) {
				toSort[row]=matrix[row][col];
			}
			sortColumn(toSort,0,toSort.length-1);
			for(int row=0; row < r; row++) {
				matrix[row][col]=toSort[row];
			}
		}
	}
	
	//sorts using mergeSort
	/* 
	 * Sort function that takes in an array of integers and a left and right index
	 * to represent the subarray to be sorted. This function will first split the subarray
	 * in roughly equal halves, sort those, then merge the subarrays together.
	 * Parameters: an array of integers to be sorted, integer representing left index, 
	 * and integer representing the right index
	 * Modifies the array  in place.
	 */
	private static void sortColumn(Integer[] sequence, int left, int right) {
		if(left < right) {
			int middle = (left+right)/2;
			sortColumn(sequence,left,middle);
			sortColumn(sequence, middle+1,right);
			merge(sequence,left, middle,right);
		}		
	}
	
	
	/*
	 * Helper function for mergesort. Merges two "partitions" of the array
	 * that are given by the parameters lIndex, middle, and rIndex. 
	 * The first partition is from lIndex to middle. and the other partition is from middle to rIndex.
	 * Parameters: Array of integers to sort, leftmost index of left partition, middle (i.e. pivot),
	 *  rightmost index of right partition
	 * MODIFIES array in place.
	 */
	private static void merge(Integer[] sequence, int lIndex, int middle, int rIndex) {
		
		int size1 = middle - lIndex + 1;
		int size2 = rIndex - middle;
		
		Integer[] left = new Integer[size1];
		Integer[] right = new Integer[size2];
		
		for (int i=0; i < size1; ++i) {
			left[i] = sequence[lIndex+i];
		}
		for (int j=0; j<size2;++j) {
			right[j] = sequence[middle+1+j];
		}
		
		int i=0,j=0;
		int k =lIndex;
		while(i<size1 && j< size2) {
			if (left[i] <= right[j]) {
				sequence[k] = left[i];
				i++;
			}else {
				sequence[k]=right[j];
				j++;
			}
			k++;
		}
		while(i < size1) {
			sequence[k] = left[i]; 
            i++; 
            k++; 
		}
		while (j < size2) { 
            sequence[k] = right[j]; 
            j++; 
            k++; 
        } 
	}
	
	/*
	 * Converts a list of integers into a 2D array with r rows and s cols.
	 * The function places the items columns-first. I.E.
	 * a list of [a,b,c,d,e,f], 2, 3 becomes [[a,b,c][d,e,f]]
	 * Parameters: list of integers, int row, int cols
	 * Returns a RxS matrix.s
	 * 
	 */
	private static Integer[][] toMatrix(Integer[] nums, int r, int s){
		Integer[][] result = new Integer[r][s];
		for (int index =0; index <nums.length; index++) {
			int val = nums[index];
			int col = index%s;
			int row = index/s;
			result[row][col]=val;
		}
		return result;
	}
	 
	/*
	 * Calculates the transpose of the matrix.
	 * Parameters: RxS Matrix
	 * Returns: SxR Matrix
	 * 
	 */
	private static Integer[][] transpose(Integer[][] matrix){
		Integer[][] result = new Integer[matrix[0].length][matrix.length];
		for(int i=0; i < matrix.length; i++) {
			for (int j = 0; j < matrix[0].length; j++) {
				result[j][i]=matrix[i][j];
			}
		}
		return result;
	}
	
	
	/*
	 * Reshapes the matrix by taking each row from the sxr Matrix
	 * and changing it to a r/s xs submatrix.
	 * Returns a RxS Matrix.	 * 
	 */
	private static Integer[][] reshape(Integer[][] matrix){
		int r = matrix[0].length;
		int s = matrix.length;
		Integer[][] result = new Integer[r][s];
		for (int i = 0; i < s; i++) {
			 for (int j = 0; j < r; j++) {
				 result[i * (r/s) + (int)(j/s)][j%s] = matrix[i][j];
			 }
		}
		return result;
		
	}
	/*
	 * Inverse of the "reshape" function. Given a matrix, will compile
	 * r/s rows into 1 row.
	 * Returns a 2d array of integers representing the matrix
	 */
	private static Integer[][] reshapeInverse(Integer[][] matrix) {
		int r = matrix.length;
		int s = matrix[0].length;
		Integer[][] result = new Integer[s][r];
		for (int i =0; i < r; i++) {
			for (int j = 0; j < s; j++) {
				result[i/(r/s)][(i*s + j) % r]=matrix[i][j];
			}
		}
		return result;
	}
	
	
	/*
	 * Reads in a filelocation and converts the file into a list of integers
	 * Assumes that the file only holds integers separated by a newline
	 * 
	 */
	private static Integer[] readFile(String filename)
	{
	  List<Integer> records = new ArrayList<>();
	  try
	  {
	    BufferedReader reader = new BufferedReader(new FileReader(filename));
	    String line;
	    while ((line = reader.readLine()) != null)
	    {
	      records.add(Integer.valueOf(line));
	    }
	    reader.close();
	    return records.toArray(new Integer[records.size()]);
	  }
	  catch (Exception e)
	  {
	    System.err.format("Exception occurred trying to read '%s'.", filename);
	    e.printStackTrace();
	    return null;
	  }
	 
	}
	//goals is to find the dimensions that make the matrix 
	//the closest to the rule r = 2(s-1)^2 and N = rs
	//This function looks at all possible pairs of values and finds the one closest
	// to fitting the rule r=2(s-1)^2 and r%s ==0 and N = r*s.
	//Returns: a 2-element int array representing [rows,cols]
	private static int[] findDimensions(int size) {
		int[][] ints = findAllFactors(size);
		int[] closestPair = new int[2];
		Integer minClose = null;
		for (int[] pair : ints) {
			int r = pair[1];
			int s = pair[0];
			int curClose =  r - 2*(int)Math.pow(s-1,2);
			if (minClose == null) {
				minClose = curClose;
			}
			if (curClose <= minClose && curClose >=0) {
				minClose = curClose;
				closestPair[0] = r;
				closestPair[1] = s;
			}
		}
		return closestPair;		
	}
	
	/*Given an int n, returns all the factor pairs of n as an array of size-2 int arrays
	 * such that each pair (v1,v2), v2%v1 = 0.
	 * i.e. [[1,n],[2,n/2]...]
	 * Parameters: int n
	 * Returns : a 2-dimensional array of ints representing all factor pairs
	 */
	private static int[][] findAllFactors(int n) {
		List<int[]> integers = new ArrayList<>();
		int[] basecase = {1,n};
		integers.add(basecase);
		for (int i = 2; i <= Math.sqrt(n); i++) {
			if (n % i ==0 && ((n/i) % i ==0 )) {
				int[] factorPair = {i,n/i};
				integers.add(factorPair);
			}
		}
		return integers.toArray(new int[integers.size()][2]);
	}

}
