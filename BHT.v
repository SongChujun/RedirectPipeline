module BHT(clk_sys,IFpc,IFpcchoose,Expcchoose,Exnpc,IFnpc,Expc,pcclear,isjmp);
input clk_sys;
input[31:0] IFpc;
output reg IFpcchoose=0;
output reg[31:0] IFnpc=0;
input Expcchoose;
input[31:0] Exnpc;
input[31:0] Expc;
input isjmp;
output reg pcclear=0;
reg valid[0:7];
reg[31:0] addr[0:7];
reg[31:0] prepc[0:7];
reg[1:0] prehis[0:7];
reg[8:0] LRUtag[0:7];
reg[8:0] largesttag=0;
parameter initialprehisnum=2'b01; 
integer i=0;
integer j=0;
integer k=0;
initial
begin
    for(i=0;i<8;i=i+1)
    begin
        valid[i]=0;
        addr[i]=0;
        prepc[i]=0;
        prehis[i]=0;
        LRUtag[i]=0;
    end
end
always@(IFpc)
begin
    for(i=0;((i<8)&&(addr[i]!=IFpc));i=i+1)
    begin
        k=i;
    end
    if(i==8)//can not find
    begin
        IFpcchoose=0;
        IFnpc=0;
    end
    else
    begin
        if((prehis[i])<2'b10)
        begin
            IFpcchoose=0;
            IFnpc=0;
        end
        else
        begin
            IFpcchoose=1;
            IFnpc=prepc[i];
        end
    end
end
always@(negedge clk_sys)
begin
    if((Expcchoose==0)&&(isjmp))//鏄烦杞絾鏄病棰勬祴
    begin
        for(i=0;((i<8)&&(addr[i]!=Expc));i=i+1)
        begin
            k=i;
        end
        if(i==8)//not in the list
        begin
            for(i=0;((i<8)&&(valid[i]));i=i+1)
            begin
                k=i;
            end
            if(i==8)//the cache is full
            begin
                for(i=0;i<8;i=i+1)
                begin
                    if(LRUtag[i]>largesttag)
                        largesttag=LRUtag[i];
                end
                for(i=0;((i<8)&&(LRUtag[i]!=largesttag));i=i+1)
                begin
                    k=i;
                end
                valid[i]=1;
                addr[i]=Expc;
                prepc[i]=Exnpc;
                prehis[i]=initialprehisnum;
                LRUtag[i]=0;
            end
            else
            begin
                valid[i]=1;
                addr[i]=Expc;
                prepc[i]=Exnpc;
                prehis[i]=initialprehisnum;
                LRUtag[i]=0;
            end
        end
        else//exist in the list
        begin
            if(prehis[i]!=2'b11)
                prehis[i]=prehis[i]+1;
            LRUtag[i]=0;
        end
        pcclear=1;
    end
    else if((Expcchoose!=0)&&(isjmp))//鍒嗘敮鎴愬姛
    begin
        for(i=0;((i<8)&&(addr[i]!=Expc));i=i+1)
        begin
            k=i;
        end
        if(prehis[i]!=2'b11)
            prehis[i]=prehis[i]+1;
        LRUtag[i]=0;
        // for(j=0;((j<i)&&(j<8));j=j+1)
        //     LRUtag[j]=LRUtag[j]+1;
        // for(j=i+1;((j>0)&&(j<8));j=j+1)
        //     LRUtag[j]=LRUtag[j]+1;
        if(i!=0)
            LRUtag[j]=LRUtag[j]+1;
        if(i!=1)
            LRUtag[j]=LRUtag[j]+1;
        if(i!=2)
            LRUtag[j]=LRUtag[j]+1;
        if(i!=3)
            LRUtag[j]=LRUtag[j]+1;
        if(i!=4)
            LRUtag[j]=LRUtag[j]+1;
        if(i!=5)
            LRUtag[j]=LRUtag[j]+1;
        if(i!=6)
            LRUtag[j]=LRUtag[j]+1;
        if(i!=7)
            LRUtag[j]=LRUtag[j]+1;
        if(i!=8)
            LRUtag[j]=LRUtag[j]+1;
        pcclear=0;
    end
    else if((Expcchoose==0)&&(!isjmp))
    begin
        pcclear=0;
    end
    else if((Expcchoose!=0)&&(!isjmp))
    begin
        for(i=0;((i<8)&&(addr[i]!=Expc));i=i+1)
        begin
            k=i;
        end
        if(prehis[i]!=2'b00)
            prehis[i]=prehis[i]-1;
        pcclear=1;
    end
end
endmodule

