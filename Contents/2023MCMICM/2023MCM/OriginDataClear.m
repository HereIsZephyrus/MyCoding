load data_origin.mat
Category_Make{1}=unique(Make{1});
Category_Variant{1}=unique(Variant{1});
Category_Regin{1}=unique(Region{1});
Category_Make{2}=unique(Make{2});
Category_Variant{2}=unique(Variant{2});
Category_Regin{2}=unique(Region{2});
save data_origin_clear.mat