clc;clear
load data.mat

numSummer=length(yearSummer);
numWinter=length(yearWinter);


%% 增长趋势拟合
for i=1:numSummer
    E_real_Summer(i)=economicSummer(i,2);
    E_predict_Summer(i)=(economicSummer(i,1)+economicSummer(i,3))/2;
    E_Summer(i,1)=(E_real_Summer(i)-E_predict_Summer(i))/E_real_Summer(i);
    E_Summer(i,2)=incomeSummer(i)/investmentSummer(i);

    T_real_Summer(i)=tourismSummer(i,2);
    T_predict_Summer(i)=(tourismSummer(i,1)+tourismSummer(i,3))/2;
    T_Summer(i)=(T_real_Summer(i)-T_predict_Summer(i))/T_real_Summer(i);

    %{
    for j=1:5
        %x=linspace(-2,2,100);
        %eco=polyfit([-2,-1,1,2],Econimic{i,j});
        %tour=polyfit([-2,-1,1,2],Tourism{i,j});
        %Fitting1=polyval(eco,x,3);
        E_real(i,j)=;
        E_predict(i,j)=Fitting1(0);
        %Fitting2=polyval(tour,x,3);
        T_predict(i,j)=Fitting2(0);
    end
    %}
end
%dieaseSummer=rand(size(gymSummer),'like',gymSummer);
L_Summer(:,1)=gymSummer;
L_Summer(:,2) = Min2Max(dieaseSummer./gymSummer);

%% 秩和比法求R
E0_Summer=zeros(2);
E0_Summer(1,:)=minmax(E_Summer(:,1)');
E0_Summer(2,:)=minmax(E_Summer(:,2)');
ER_Summer=zeros(size(E_Summer),'like',E_Summer);
for i=1:2
    for j=1:numSummer
        ER_Summer(j,i)=1+(numSummer-1)*(E_Summer(j,i)-E0_Summer(i,1))/(E0_Summer(i,2)-E0_Summer(i,1));
    end
end

T0_Summer=minmax(T_Summer);
TR_Summer=zeros(size(T_Summer),'like',T_Summer)';
for j=1:numSummer
    TR_Summer(j)=1+(numSummer-1)*(T_Summer(j)-T0_Summer(1))/(T0_Summer(2)-T0_Summer(1));
end

S0_Summer=minmax(satisfactionSummer');
SR_Summer=zeros(size(satisfactionSummer),'like',satisfactionSummer);
for j=1:numSummer
    SR_Summer(j)=1+(numSummer-1)*(satisfactionSummer(j)-S0_Summer(1))/(S0_Summer(2)-S0_Summer(1));
end

L0_Summer(1,:)=minmax(L_Summer(:,1)');
L0_Summer(2,:)=minmax(L_Summer(:,2)');
for i=1:2
    for j=1:numSummer
        LR_Summer(j,i)=1+(numSummer-1)*(L_Summer(j,i)-L0_Summer(i,1))/(L0_Summer(i,2)-L0_Summer(i,1));
    end
end

%% 秩和比法求RSR
for i=1:numSummer
    ecoSummer(i)=sum(ER_Summer(i,:))/(size(ER_Summer,2)*numSummer);
    tourSummer(i)=sum(TR_Summer(i,:))/(size(TR_Summer,2)*numSummer);
    satSummer(i)=sum(SR_Summer(i,:))/(size(SR_Summer,2)*numSummer);
    landSummer(i)=sum(LR_Summer(i,:))/(size(LR_Summer,2)*numSummer);
    %brandSummer(i)=sum(BR_Summer(i,:))/(size(BR_Summer,2)*numSummer);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 增长趋势拟合
for i=1:numWinter
    E_real_Winter(i)=economicWinter(i,2);
    E_predict_Winter(i)=(economicWinter(i,1)+economicWinter(i,3))/2;
    E_Winter(i,1)=(E_real_Winter(i)-E_predict_Winter(i))/E_real_Winter(i);
    E_Winter(i,2)=incomeWinter(i)/investmentWinter(i);

    T_real_Winter(i)=tourismWinter(i,2);
    T_predict_Winter(i)=(tourismWinter(i,1)+tourismWinter(i,3))/2;
    T_Winter(i)=(T_real_Winter(i)-T_predict_Winter(i))/T_real_Winter(i);

    %{
    for j=1:5
        %x=linspace(-2,2,100);
        %eco=polyfit([-2,-1,1,2],Econimic{i,j});
        %tour=polyfit([-2,-1,1,2],Tourism{i,j});
        %Fitting1=polyval(eco,x,3);
        E_real(i,j)=;
        E_predict(i,j)=Fitting1(0);
        %Fitting2=polyval(tour,x,3);
        T_predict(i,j)=Fitting2(0);
    end
    %}
end
%dieaseWinter=rand(size(gymWinter),'like',gymWinter);
L_Winter(:,1)=gymWinter;
L_Winter(:,2) = Min2Max(dieaseWinter./gymWinter);

%% 秩和比法求R
E0_Winter=zeros(2);
E0_Winter(1,:)=minmax(E_Winter(:,1)');
E0_Winter(2,:)=minmax(E_Winter(:,2)');
ER_Winter=zeros(size(E_Winter),'like',E_Winter);
for i=1:2
    for j=1:numWinter
        ER_Winter(j,i)=1+(numWinter-1)*(E_Winter(j,i)-E0_Winter(i,1))/(E0_Winter(i,2)-E0_Winter(i,1));
    end
end

T0_Winter=minmax(T_Winter);
TR_Winter=zeros(size(T_Winter),'like',T_Winter)';
for j=1:numWinter
    TR_Winter(j)=1+(numWinter-1)*(T_Winter(j)-T0_Winter(1))/(T0_Winter(2)-T0_Winter(1));
end

S0_Winter=minmax(satiffactionWinter');
SR_Winter=zeros(size(satiffactionWinter),'like',satiffactionWinter);
for j=1:numWinter
    SR_Winter(j)=1+(numWinter-1)*(satiffactionWinter(j)-S0_Winter(1))/(S0_Winter(2)-S0_Winter(1));
end

L0_Winter(1,:)=minmax(L_Winter(:,1)');
L0_Winter(2,:)=minmax(L_Winter(:,2)');
for i=1:2
    for j=1:numWinter
        LR_Winter(j,i)=1+(numWinter-1)*(L_Winter(j,i)-L0_Winter(i,1))/(L0_Winter(i,2)-L0_Winter(i,1));
    end
end

%% 秩和比法求RSR
for i=1:numWinter
    ecoWinter(i)=sum(ER_Winter(i,:))/(size(ER_Winter,2)*numWinter);
    tourWinter(i)=sum(TR_Winter(i,:))/(size(TR_Winter,2)*numWinter);
    satWinter(i)=sum(SR_Winter(i,:))/(size(SR_Winter,2)*numWinter);
    landWinter(i)=sum(LR_Winter(i,:))/(size(LR_Winter,2)*numWinter);
    %brandWinter(i)=sum(BR_Winter(i,:))/(size(BR_Winter,2)*numWinter);
end


save HostedState.mat