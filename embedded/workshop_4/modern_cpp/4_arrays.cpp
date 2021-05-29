#include <iostream>

int main() {
	using namespace std;

	int arr[5] = { 20,21,22,23,24 };

	cout << "arr: " << arr << endl;
	cout << "sizeof(arr): " << sizeof(arr) << endl;
	for (int c = 0; c < 5; c++) {
		cout << "c: " << c;
		cout << " &arr[c]: " << &arr[c];
		cout << " arr + c: " << arr + c << " ";
		cout << "  arr[c]: " << arr[c] << endl;
	}

	double  arr_2d [2][3] = {{1.1,2.2,3.3},
	                         {4.4,5.5,6.6}};

	cout << "\narr_c_2d: " << arr_2d << endl;
	cout << "sizeof(arr_2d): " << sizeof(arr_2d) << endl;

	double * arr_p = (double *)arr_2d;
	cout << "sizeof(arr_p ): " << sizeof(arr_p) << endl;

	for (int r = 0; r < 2; r++)
		for (int c = 0; c < 3; c++) {
			cout << "r: " << r << " c: " << c;
			cout << " &arr_c_2d[r][c]: " << &arr_2d[r][c];
			cout << " arr_c_2d + r*3 + c: " << arr_p + r*3 + c << " ";
			cout << "  arr_c_2d[r][c]: " << arr_2d[r][c] << endl;
		}
}