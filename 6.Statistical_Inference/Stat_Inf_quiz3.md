    ## Q1
    s = 30/sqrt(9)
    1100 + c(-1,1)*qt(0.975,df=8)*s

    ## [1] 1076.94 1123.06

    ## Q2
    2*3/qt(0.975,df=8)

    ## [1] 2.601903

    ## Q4
    sp2 = (0.6+0.68)/2
    df = 20-2
    Z = (3 - 5)/sqrt(sp2)
     (3-5) + c(-1,1)*qt(0.975, df=18)*sqrt(sp2/10 + sp2/10)

    ## [1] -2.751649 -1.248351

    ## Q6
    sp2 = (1.5^2 + 1.8^2)/2
    df = 18-2
    Z = (3 - 5)/sqrt(sp2)
     (-3-1) + c(-1,1)*qt(0.95, df=16)*sqrt(sp2/9 + sp2/9)

    ## [1] -5.363579 -2.636421
