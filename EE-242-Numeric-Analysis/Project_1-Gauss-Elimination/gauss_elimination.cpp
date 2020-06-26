#include <iostream>
#include <fstream>
#include <string>
#include <new>
#include <cmath>
using namespace std;

int main() {
    int n=0,k=0;
    string line;
    float **matrix;

    ifstream myfile2 ("b.txt");


    if(myfile2.is_open()){
        while(getline(myfile2,line)){
            n++; //to understand the size of the matrix b,we have used the getline,
        }
    }

    else cout<<"the document b.txt could not be taken"<<endl;//if the file cannot be opened

    float *b= new float[n]; //when taking file from user,we should use dynamic memory,
    myfile2.close(); //to read the beginning of the file b.txt, we should closed it at reopen,
    ifstream myfile3 ("b.txt");

    for(int i=0;i<n;i++){
        myfile3>>b[i]; //

    }

//like b.txt , to read the nxn matrix we will use dynamic memory

    matrix = new float*[n];
    for(int j=0;j<n;j++)	{
        matrix[j]= new float[n];
    }


    ifstream myfile ("A.txt");

    if(myfile.is_open()){
        for(int i=0;i<n;i++){
            for(int m=0;m<n;m++){

                myfile>>matrix[i][m];


            }
        }
    }
    float **a = new float*[n];
    for(int j=0;j<n;j++)	{
        a[j]= new float[n];
    }
    myfile.close();
    ifstream afile ("A.txt");
     if(afile.is_open()){
        for(int i=0;i<n;i++){
            for(int m=0;m<n;m++){

                myfile>>a[i][m];


            }
        }
    }
    if(afile.is_open()){
        for(int i=0;i<n;i++){
            for(int m=0;m<n;m++){

                afile>>a[i][m];


            }
        }
    }
 

    float s=-1;
    int t;
    float katsayi;
    float e_mach=5e-6;//in floating aritmatic


//if matrix A is 2x2,
    float d,cond_number1,cond_numberinf;
    float x_1,x_2,x_3,x_4;

    
    
    

    int i,control;
    for(i=0;i<n;i++){
s=0;
        for(k=i;k<n;k++){
            //to make s<0
            if(abs(matrix[k][i]) > s){
//to use partial pivoting method,we should determine the maxmimim absolute value of the member of a column
                t=k;
                s=abs(matrix[k][i]);
            }
        }

        if(s<e_mach){
//if the maximum absolute value of the member of column is smaller than machine precision , it means that , it is nearly zero,
//so the matrix will be singular, so i choose e_mach=10^-8
          cout<<"singular";
          control=n+2;
		    break;
        }
        for(int p=i;p<n;p++){
//changing the two rows,one of which has the maximum absolute value of members of column,
            float y=matrix[i][p];
            matrix[i][p]=matrix[t][p];
            matrix[t][p]=y;


        }
        //we should do the same row operation in b matrix
        float x=b[i];
        b[i]=b[t];
        b[t]=x;



        for(int z=i+1;z<n;z++){
            katsayi=matrix[z][i]/matrix[i][i];//to use gauss elimination, katsayi = the ratio of the firs memmbers of rows,

            for(int r=0;r<n;r++){

                matrix[z][r]=matrix[z][r]-katsayi*matrix[i][r];//gauss elimination
            }
            b[z]=b[z]-katsayi*b[i];//we should do same operation in the b matrix


        }



        t=i+1;//to start row operation at below of the main row
    }
    cout<<"\n";
if(control!=n+2){

 {
        if (n == 2) {
            x_1 = abs(a[0][0]) + abs(a[1][0]);
            x_2 = abs(a[0][1]) + abs(a[1][1]);
            x_3 = abs(a[0][0]) + abs(a[0][1]);
            x_4 = abs(a[1][0]) + abs(a[1][1]);
            d = a[0][0] * a[1][1] - a[0][1] * a[1][0];
            d = abs(d);

            if (x_1 >= x_2) {//for matrix A
                cond_number1 = x_1;
                cond_numberinf = x_1 / d;
            } else {
                cond_number1 = x_2;
                cond_numberinf = x_2 / d;
            }
            if (x_3 >= x_4) {//FOR MATRIX A INVERSE
                cond_number1 = cond_number1 * x_3 / d;//
                cond_numberinf = cond_numberinf * x_3;
            } else {
                cond_number1 = cond_number1 * x_4 / d;
                cond_numberinf = cond_numberinf * x_4;
            }//note that condition number at 1 and at inf are equal to each other
            // because we are comparing x1,x2  and  x3,x4  in both case
            cout << "condition number at 1 : " << cond_number1 << endl;
            cout << "condition number at inf : " << cond_numberinf<<endl;//
        }
    }
    
}
    int q,r;
    float cozum[n][1];
    if(control!=n+2) {//it is important because if at least one pivot is equal to zero, we should not find the resul matrix
        for (q = n - 1; q > -1; q--) {
            cozum[q][0] = b[q];
            for (r = n - 1; r > q; r--) {

                cozum[q][0] = cozum[q][0] - matrix[q][r] * cozum[r][0];//back substitution

            }
            cozum[q][0] = cozum[q][0] / matrix[q][q];//dividing the pivot value

        }
        cout<<"the solution is :"<<endl;
        for(int i=0;i<n;i++){
            cout<<cozum[i][0]<<endl;
        }
    }



//to create result file
    ofstream result_file ("x.txt");
    if(result_file.is_open()){
        for(int i=0;i<n;i++){
            result_file << cozum[i][0]<<endl;
        }
        result_file.close();
    }
    else{
        cout<<"x.file cannot open";
    }

    return 0;
}