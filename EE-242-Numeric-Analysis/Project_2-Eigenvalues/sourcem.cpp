#include<iostream>
#include<new>
#include<cmath>
#include <fstream>
#include <string>
#include <sstream>

using namespace std;

//we have create matrix class to define operations
class matrix{
public:
    int row,column;
    float **a;

    matrix(int m,int n){
        row=m;
        column=n;
        a=new float *[row]; // we have used dynamically allocated memory to determine matrix
        for(int k=0;k<row;k++){
            a[k]=new float[column];
        }

    }
    matrix operator* (const matrix&); //matrix multiplication operation
    matrix operator+ (const matrix&); //matrix substraction operator
    matrix operator^ (const matrix&); //matrix transpose operation


};
matrix matrix::operator* (const matrix& param){
    matrix temp(row,param.column);
    for(int i=0;i<row;i++){ // all initial values are zero to avoid some mistakes
        for(int j=0;j<param.column;j++){
            temp.a[i][j]=0;
        }
    }
    if(column==param.row){ //the property of matrix multiplication
        for(int p=0;p<row;p++){
            for(int r=0;r<param.column;r++){

                for(int i=0;i<column;i++){
                    temp.a[p][r]=temp.a[p][r]+(a[p][i]*param.a[i][r]);
                }

            }
        }


    }

    return temp;
}
// substraction operation
matrix matrix::operator+ (const matrix& param){
    matrix temp(row,column);
    if(row==param.row && column==param.column){

        for(int i=0;i<row;i++){
            for(int j=0;j<column;j++){
                temp.a[i][j]=a[i][j]-param.a[i][j];
            }
        }



    }

    return temp;
}
//transpose operation
matrix matrix::operator^ (const matrix& param){
    matrix temp(column,row);
    for(int i=0;i<row;i++){
        for(int j=0;j<param.column;j++){
            temp.a[j][i]=0;
        }
    }
    for(int i=0;i<column;i++){
        for(int j=0;j<row;j++){
            temp.a[i][j]=a[j][i];
        }
    }


    return temp;
}


int main(int argc,char *argv[]){

    float tolerance = atof(argv[2]);



    int n=0;
    string line;
    float **matrixim;

    ifstream myfile2 (argv[1]);


    if(myfile2.is_open()){
        while(getline(myfile2,line)){
            n++; //to understand the size of the matrix A,we have used the getline,
        }
    }

    else cout<<"the document A.txt could not be taken"<<endl;//if the file cannot be opened

    matrixim = new float*[n];
    for(int j=0;j<n;j++)	{
        matrixim[j]= new float[n];
    }
    myfile2.close();


    ifstream myfile (argv[1]);

    if(myfile.is_open()){
        for(int i=0;i<n;i++){
            for(int m=0;m<n;m++){

                myfile>>matrixim[i][m];


            }
        }
    }
    myfile.close();



    int xc=n;
    int xd=n;



    matrix x(xc,xd);

    for(int i=0;i<xc;i++){//determeinin the matrix values of x.a
        for(int j=0;j<xd;j++){
            x.a[i][j]=matrixim[i][j];
        }
    }


    matrix ex(n,1);//ex is the random matrix for power iteration method (x0)
    ex.a[0][0]=1;
    for(int i=1;i<n;i++){
        ex.a[i][0]=1/i;
    }


   float s=-1;
    float k=-100;
//note that x is our main matrix

// power iteration method to define both eigenvalue and eigen matrix
    for(int i=0;i<1000;i++){
        s=-1;
        ex=x*ex;
        for(int j=0;j<n;j++) {
            if (abs(ex.a[j][0]) > s) {
                s = abs(ex.a[j][0]);// to define max value of the ex vector

            }
        }
        for(int j=0;j<n;j++) {

            ex.a[j][0]= ex.a[j][0]/s;//normalization

        }

        if(abs(s-k)<tolerance){//to determine convergence
            break;
        }
        k=s;


    }
    float first_eigenvalue=s;//this value is our first eigen vaule

    matrix v(n,1);
    float norm=0;
    for(int i=0;i<n;i++){
        norm=norm+ex.a[i][0]*ex.a[i][0];
    }
    norm=sqrt(norm);
    if(ex.a[0][0]>=0){
        norm=norm*(-1);
    }

    matrix e1(n,1);
    e1.a[0][0]=norm;//for householder we should select e1 matrix as a unit vector*norm
    for(int i=1;i<n;i++){
        e1.a[i][0]=0;
    }
    v=ex+e1;//to determine v for householder

    matrix identity(n,n);//defining the idebtity matrix
    for(int i=0;i<n;i++){
        for(int j=0;j<n;j++){
            if(i==j){
                identity.a[i][j]=1;
            }
            else{
                identity.a[i][j]=0;
            }
        }
    }
    // finding the householder matrix

    matrix yeni(n,n);
    yeni=v*(v^v);
    matrix yeni1(1,1);
    yeni1=(v^v)*v;
    float katsayi=2/yeni1.a[0][0];

    for(int i=0;i<n;i++){
        for(int j=0;j<n;j++){
            yeni.a[i][j]=katsayi*yeni.a[i][j];
        }
    }
    matrix H(n,n);
    H=identity+yeni;//note that + is our substraction operator
    matrix B(n,n);

    B=H*x;
    B=B*H;//B=H*x*H H inverse is equal to H
    cout<<B.a[0][0]<<endl;
    if(B.a[0][0]*s*ex.a[0][0]<0){// if b.a[0][0] is negative then our first eigenvalu should be negative
        first_eigenvalue=-first_eigenvalue;
    }
    cout<<"1.eigen value is: "<<first_eigenvalue<<endl;
    cout<<"first eigenvector is: "<<endl;
    for(int j=0;j<n;j++) {

        cout<<ex.a[j][0]<<endl;

    }


    matrix C(n-1,n-1);//to define second eigenvalue
    for(int i=1;i<n;i++){
        for(int j=1;j<n;j++){
            C.a[i-1][j-1]=B.a[i][j];
        }
    }

k=-100;

    matrix ex2(n-1,1);//ex will be our second eigenvector
    ex2.a[0][0]=1;
    for(int i=1;i<n-1;i++){
        ex2.a[i][0]=0;
    }

    for(int i=0;;i++){
        s=-1;
        ex2=C*ex2;
        for(int j=0;j<n-1;j++) {
            if (abs(ex2.a[j][0]) > s) {
                s = abs(ex2.a[j][0]);

            }
        }
        for(int j=0;j<n-1;j++) {

            ex2.a[j][0]= ex2.a[j][0]/s;

        }

        if(abs(s-k)<tolerance){
            break;
        }
        k=s;

    }

    matrix kontrol(n-1,1);
    kontrol=C*ex2;
    float esitmi=s*(ex2.a[0][0]);

    if(kontrol.a[0][0]*esitmi <0){//to understand whether the second eigenvalu is positive or negative
        s=-s;

    }

    float second_eigenvalu=s;

    cout<<"second eigen value is: "<<second_eigenvalu<<endl;



//to create result file
    ofstream result_file (argv[3]);
    if(result_file.is_open()){
        result_file<<"Eigenvalue#1: "<<first_eigenvalue<<endl;
        for(int i=0;i<n;i++){
            result_file << ex.a[i][0]<<endl;
        }
        result_file<<"Eigenvalue#2: "<<second_eigenvalu<<endl;
        result_file.close();

    }
    else{
        cout<<"x.file cannot open";
    }
    result_file.close();


    return 0;
}
