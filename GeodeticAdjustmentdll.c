#include<math.h>
#include<stdio.h>
const double pi=3.141592653589793238463;
const double p0=206264.8062470963551564;

const double a[4]={6378245,6378140,6378137,6378137};
const double b[4]={6356863.0187730473,6356755.2881575287,6356752.3142,6356752.3141};
const double c[4]={6399698.9017827110,6399596.6519880105,6399593.6258,6399593.6259};
const double e[4]={0.0066934216229660,0.006694384999588,0.00669437999013,0.00669438002290};
const double e1[4]={0.006738525414683,0.006739501819473,0.00673949674227,0.00673949677548};


//白塞尔大地主题正算
void BesselDirect(double* result, double L1, double B1, double A1, double S, int earth){
    //角度改弧度
    L1/=(180/pi); B1/=(180/pi); A1/=(180/pi);

    //椭球面归化到球面
    double u1= atan(sqrt(1 - e[earth]) * tan(B1));
    double M = atan( tan(u1) / cos(A1) );
    double m = asin( cos(u1) * sin(A1) );
    M = M>0 ? M : M+pi; m = m>0 ? m : m+2*pi;

    double k2 = e[earth]/(1-e[earth]) * cos(m) * cos(m);
    double a1 = sqrt(1 + e[earth]/(1-e[earth])) / a[earth] * (1 - k2/4 + 7/64*k2*k2 - 15/256*k2*k2*k2);
    double b1 = k2/4 - k2*k2/8 + 37/512*k2*k2*k2;
    double y1 = (k2*k2 - k2*k2*k2) / 128;
    double o1 = a1 * S;
    double o2;
    while(1){
        o2 = a1 * S + b1 * sin(o1) * cos(2 * M + o1) + y1 * sin(2 * o1) * cos(4 * M + 2 * o1);
        if (abs(o1 - o2) < 0.1 / 180 * pi )
            break;
        o1 = o2;
    }
    double o = o2;

    //解算
    double A2 = atan(tan(m) / cos(M + o));
    A2 = (A2<0||A1<pi) ? A2+pi : A2;

    double u2 = atan(-cos(A2) * tan(M + o));
    double l1 = atan(sin(u1) * tan(A1));
    l1 = (l1<0||m>pi) ? l1+pi : l1;

    double l2 = atan(sin(u2) * tan(A2));
    l2 = ( l2 < 0 || ((m<pi&&M+o>pi) || (m>pi&&M+o<pi) ) ) ? l2+pi : l2;

    //球面归算到椭球面
    double B2 = atan(sqrt(1 + e[earth]/(1-e[earth])) * tan(u2));
    o2 = (0.5 + e[earth] / 8 - e[earth] * e[earth] / 16) * e[earth] - (e[earth] / 16 * (1 + e[earth]) * k2 - 3 / 128 * e[earth] * k2*k2 );
    double b2 = (e[earth] / 16 * (1 + e[earth]) * k2 - e[earth] / 32 * k2 * k2 );
    double y2 = e[earth] / 256 * k2 * k2;
    double L2 = L1 + l2 - l1 - sin(m) * (o2 * o + b2 * sin(o) * cos(2 * M + o) + y2 * sin(2 * o) * cos(4 * M + 2 * o));

    result[0]= L2/pi*180;
    result[1]= B2/pi*180;
    result[2]= A2/pi*180;
    return;
}

//白塞尔大地主题反算
void BesselInverse(double* result,double L1, double B1, double L2, double B2, int earth){
    //角度改弧度
    L1/=(180/pi); B1/=(180/pi); L2/=(180/pi); B2/=(180/pi);

    //椭球面归化到球面
    double u1 = atan(sqrt(1 - e[earth]) * tan(B1));
    double u2 = atan(sqrt(1 - e[earth]) * tan(B2));
    double o = acos(sin(u1) * sin(u2) + cos(u1) * cos(u2) * cos(L2-L1));

    double m = asin(cos(u1) * cos(u2) * sin(L2-L1) / sin(o));
    double k2 = e[earth]/(1-e[earth]) * cos(m) * cos(m);
    double a2 = (1 / 2 + e[earth] / 8 - e[earth] * e[earth] / 16) * e[earth] - e[earth] / 16 * (1 + e[earth]) * k2 + 3 / 128 * e[earth] * k2 * k2;
    double dl = a2 * o * sin(m);
    double dO = sin(m) * dl;
    double m1 = asin(cos(u1) * cos(u2) * sin(L2 - L1 + dl) / sin(o+dO));
    double A10 = atan(sin(L2 - L1 + dl) / (cos(u1) * tan(u2) - sin(u1) * cos(L2 - L1 + dl)));
    A10 = (A10<0||m1<0) ? A10+pi : A10;
    double M1 = atan(sin(u1) * tan(A10) / sin(m1));
    M1 = M1<0 ? M1+pi : M1;

    k2 = e[earth]/(1-e[earth]) * cos(m1) * cos(m1);
    a2 = (1 / 2 + e[earth] / 8 - e[earth] * e[earth] / 16) * e[earth] - e[earth] / 16 * (1 + e[earth]) * k2 + 3 / 128 * e[earth] * k2 * k2;
    double b2 = e[earth] / 16 * (1 + e[earth]) * k2 - e[earth] / 32 * k2 * k2;
    double l = L2 - L1 + dl + sin(m1) * (a2 * (o+dO) + b2 * sin(o+dO) * cos(2 * M1 + o+dO));

    //解算
    double O = acos(sin(u1) * sin(u2) + cos(u1) * cos(u2) * cos(l));
    double A1 = atan(sin(l) / (cos(u1) * tan(u2) - sin(u1) * cos(l)));
    m = asin(cos(u1) * sin(A1));
    A1 = (A1<0||m>0) ? A1+pi : A1;
    double M = atan(sin(u1) * tan(A10) / sin(m1));
    M = M<0 ? M+pi : M;
    double A2 = atan(sin(l) / (sin(u2) * cos(l) - tan(u1) * cos(u2)));
    A2 = (A2<0||m<0) ? A2+pi : A2;

    //球面归算到椭球面
    k2 = e[earth]/(1-e[earth]) * cos(m) * cos(m);
    double a1 = sqrt(1 + e[earth]/(1-e[earth])) / a[earth] * (1 - k2 / 4 + 7 / 64 * k2 * k2 - 15 / 256 * k2 * k2 * k2);
    double b1 = k2 / 4 - k2 * k2 / 8 + 37 / 512 * k2 * k2 * k2;
    double y1 = k2 * k2 * (1-k2) / 128;
    double S = 1 / a1 * (O - b1 * sin(O) * cos(2 * M + O) - y1 * sin(2 * O) * cos(4 * M + 2 * O));

    result[0]= A1/pi*180;
    result[1]= A2/pi*180;
    result[2]= S;
    return;
}



//高斯正算：由椭球面到平面
void GuassForward(double* result, double B, double L, int L_num, int mode, int earth){
    double L_center = (mode==0) ? 6 * L_num - 3 : 3 * L_num;
 
    double l = (L - L_center) * 3600 / p0; //经差

    B=B*pi/180;//弧度
  
    double V = sqrt(1 + e1[earth] * cos(B)*cos(B));
    double N = c[earth] / V;
	double n = e1[earth] * cos(B) * cos(B);

    double A1 = N * cos(B);
    double A2 = N * sin(B) * cos(B) / 2;
    double A3 = N * cos(B) * (cos(B)*cos(B)/3 + n*n - 1.0/6.0);
    double A4 = 2 * A2 * (cos(B)*cos(B)/4 + n*n*3/8 + e1[earth]*n*n*n/6 - 1.0/24.0);
    double A5 = N * cos(B) * (1.0/120 - cos(B)*cos(B)/6 + 0.2 - n*n*29/60 + n*n*n/e1[earth]*3/5);
    double A6 = 2 * A2 * ( 1.0/720.0 - cos(B)*cos(B)/12 +  cos(B)*cos(B)*cos(B)*cos(B)/6 );

    // X:子午圈弧长
    double m0 = a[earth] * (1 - e[earth]);
    double m2 = 3.0 / 2.0 * e[earth] * m0;
    double m4 = 5.0 / 4.0 * e[earth] * m2;
    double m6 = 7.0 / 6.0 * e[earth] * m4;
    double m8 = 9.0 / 8.0 * e[earth] * m6;
    double a0 = m0 + m2 / 2.0 + 3.0 / 8.0 * m4 + 5.0 / 16.0 * m6 + 35.0 / 128.0 * m8;
    double a2 = m2 / 2.0 + m4 / 2 + 15.0 / 32.0 * m6 + 7.0 / 16.0 * m8;
    double a4 = m4 / 8.0 + 3.0 / 16.0 * m6 + 7.0 / 32.0 * m8;
    double a6 = m6 / 32.0 + m8 / 16.0;
    double a8 = m8 / 128.0;
    double X = a0 * B - a2 / 2.0 * sin(2 * B) + a4 / 4.0 * sin(4 * B) - a6 / 6.0 * sin(6 * B) + a8 / 8.0 * sin(8 * B);

    double k =l*l;
    double x = X + A2*k + A4*k*k + A6*k*k*k;
    double y = A1*l + A3*k*l + A5*k*k*l;

    result[0]= x;
    result[1] = y;    

    return;
}

//高斯反算：平面到椭球面
void GuassBackward(double* result, double x, double y, int L_num, int mode, int earth)
{
    int L_center = (mode==0) ? 6 * L_num - 3 : 3 * L_num;    
 
    double m0 = a[earth] * (1 - e[earth]);
    double m2 = 3.0 / 2.0 * e[earth] * m0;
    double m4 = 5.0 / 4.0 * e[earth] * m2;
    double m6 = 7.0 / 6.0 * e[earth] * m4;
    double m8 = 9.0 / 8.0 * e[earth] * m6;
    double a0 = m0 + m2 / 2.0 + 3.0 / 8.0 * m4 + 5.0 / 16.0 * m6 + 35.0 / 128.0 * m8;
    double a2 = m2 / 2.0 + m4 / 2 + 15.0 / 32.0 * m6 + 7.0 / 16.0 * m8;
    double a4 = m4 / 8.0 + 3.0 / 16.0 * m6 + 7.0 / 32.0 * m8;
    double a6 = m6 / 32.0 + m8 / 16.0;
    double a8 = m8 / 128.0;
 
    double Bf = x / a0;
    double B0 = Bf;
    while ((fabs(Bf - B0) > 0.0000001) || (B0 == Bf))
    {
        B0 = Bf;
        double FBf = -a2 / 2.0 * sin(2 * B0) + a4 / 4.0 * sin(4 * B0) - a6 / 6.0 * sin(6 * B0);
        Bf = (x - FBf) / a0;
    }    //迭代求数值为x坐标的子午线弧长对应的底点纬度
 
 
    double t = tan(Bf);                           
    double V = sqrt(1 + e1[earth] * cos(Bf) * cos(Bf));  
    double N = c[earth] / V;                              
    double M = c[earth] / pow(V, 3);                   
    double n = e1[earth] * cos(Bf) * cos(Bf);             
 
    double n1 = 1 / (N * cos(Bf));
    double n2 = -t / (2.0 * M * N);
    double n3 = -(1 + 2 * t * t + n) / (6.0 * pow(N, 3) * cos(Bf));
    double n4 = t * (5 + 3 * t * t + n - 9 * n * t * t) / (24.0 * M * pow(N, 3));
    double n5 = (5 + 28 * t * t + 24 * pow(t, 4) + 6 * n + 8 * n * t * t) / (120.0 * pow(N, 5) * cos(Bf));
    double n6 = -t * (61 + 90 * t * t + 45 * pow(t, 4)) / (720.0 * M * pow(N, 5));
 
 
    double B = (Bf + n2 * y * y + n4 * pow(y, 4) + n6 * pow(y, 6)) / pi * 180;
    double l = (n1 * y + n3 * pow(y, 3) + n5 * pow(y, 5))/ pi * 180;
    result[0]= B;
    result[1] = L_center + l;

    return;
}

//高斯邻带换算
void GuassZoneConversion(double* result, double originx, double originy, int originZone, int targetZone, int mode, int earth){
    double Geodetic[2]={0,0};
    GuassBackward(Geodetic,originx,originy,originZone,mode,earth);
    GuassForward(result,Geodetic[0],Geodetic[1],targetZone,mode,earth);
    return;
}
