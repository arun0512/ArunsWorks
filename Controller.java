public class ShoppingCartController01 {
    
    Private String getProductsQuery;
    public String ProductName{get;set;}
    private Integer StartingPageRecord{get;set;}
    private Integer EndingPageRecord{get;set;}
    public boolean RenderProducts{get;set;}
    public boolean RenderCart{get;set;}
    public boolean RenderInvoice{get;set;}
    public boolean isSorted{get;set;}
    /*
    * constructor
    */
    public ShoppingCartController01() {
        RenderProducts = false;
        RenderCart = false;
        RenderInvoice = false ;
        MakeItReadOnly = false;
        isSorted = false;
        sortOrderBy = 'Id';
        SelectedWrapProducts = new List<wrapProduct>();
        tempProductList = new List<wrapProduct>();
        tempProducts = new List<Product2>();
        wrapProductMap = new Map<Id,wrapProduct>();
        for(Product2 product : getproducts()) {
            wrapProductMap.put(product.Id,new wrapProduct(product));
        }
    }
    
    /* ----------------------------- Product Section ------------------------------------ */
    
    List<Product2> tempProducts ;
    
    public ApexPages.StandardSetController setConProduct {
        get {
            if(setConProduct==null) {
                setConProduct = new ApexPages.StandardSetController(tempProducts);
                setConProduct.setPageSize(10) ;
            }
            return setConProduct;
        }
        set;
    }
    
    public list<Product2> getProducts() {
        tempProducts = [SELECT Name,ProductCode,Description,price_per_unit__c,quantity_available__c FROM Product2  LIMIT 1000];
        setConProduct.setSelected(tempProducts);
        return tempProducts;
    }
    
    public Integer getStartingPageRecord() {
        startingPageRecord = setConProduct.getPageNumber() * setConProduct.getPageSize() - (setConProduct.getPageSize() - 1);
        return startingPageRecord;
    }
    
    public Integer getEndingPageRecord() {
        EndingPageRecord = setConProduct.getPageNumber() * setConProduct.getPageSize() ;
        return Math.min(EndingPageRecord,setConProduct.getResultSize());
    }
    
    public void SortData() {
        tempProductList.sort();
        isSorted = true ;
    }
    
    public void SearchProduct() {
        tempProductList.clear();
        tempProducts.clear();
        for(Id key : WrapProductMap.keySet()) {
            if(WrapProductMap.get(key).product.Name.containsIgnoreCase(productName)) {
                tempProductList.add(WrapProductMap.get(key));
                tempProducts.add(WrapProductMap.get(key).product);
            }
        }
        setConProduct = null;
        setConProduct.setSelected(tempProducts);
        
    }
    
    /* -----------------------------------Product Wrapper and cart----------------------------------------------------- */
    
    public Map<Id,wrapProduct> WrapProductMap {get; set;}
    public List<wrapProduct> tempProductList {get ; set ;}
    public List<wrapProduct> SelectedWrapProducts {get; set;}
    public Id WrappedProductId {get;set;}
    public Integer previousQuantity {get;set;}
    public boolean MakeItReadOnly {get;set;}
    
    public class wrapProduct implements Comparable {
        public Product2 product {get; set;}
        public Boolean selected {get; set;}
        public Integer Quantity {get;set;}
        
        public wrapProduct(Product2 product) {
            this.product = product;
            selected = false;
            quantity = 1;
        }
        
        public Integer compareTo(Object o) {
            wrapProduct that = (wrapProduct) o;
            if (this.product.Name < that.product.Name) return -1;
            else if (this.product.Name > that.product.Name) return 1;
            else return 0;
        }
    }
    
    public List<wrapProduct> getWrapProducts() {
        if(isSorted == true) {
            isSorted = false;
            return tempProductList;
        }
        
        tempProductList.clear();
        for(Product2 product : (list<Product2>)setConProduct.getRecords()) {
            tempProductList.add(wrapProductMap.get(product.Id));
        }
        return tempProductList;
    }
    
    public void addSelected() {
        System.debug(WrapProductMap);
        for(Id key : WrapProductMap.keySet()) {
            if(WrapProductMap.get(key).selected == true && WrapProductMap.get(key).product.quantity_available__c > 0 ) {
                if(!SelectedWrapProducts.contains(WrapProductMap.get(key))) {
                    SelectedWrapProducts.add(WrapProductMap.get(key));
                }else{
                    WrapProductMap.get(key).quantity++;
                }
                WrapProductMap.get(key).product.quantity_available__c -- ;
            }
        }
        if(SelectedWrapProducts.size() > 0){
            RenderCart = true;
        }
    }
    
    public list<wrapProduct> getCartItems() {
        return SelectedWrapProducts;
    }
    
    public void updateQuantity() {
        
        for(Integer index = 0 ; index < SelectedWrapProducts.size() ; index++ ) {
            if(SelectedWrapProducts[index].product.Id == WrappedProductId){
                if(SelectedWrapProducts[index].quantity <= 0 || (SelectedWrapProducts[index].quantity - previousQuantity) > SelectedWrapProducts[index].product.quantity_available__c){
                    SelectedWrapProducts[index].quantity = previousQuantity;
                    return;
                }
                SelectedWrapProducts[index].product.quantity_available__c += previousQuantity - SelectedWrapProducts[index].quantity ;
            }
        } 
    }
    
    public void setPreviousQuantity() {
        
    }
    
    public void removeFromCart() {
        
        for(Integer index = 0 ; index < SelectedWrapProducts.size() ; index++ ){
            if(SelectedWrapProducts[index].product.Id == WrappedProductId){
                SelectedWrapProducts[index].product.quantity_available__c += SelectedWrapProducts[index].quantity;
                SelectedWrapProducts[index].selected = false;
                SelectedWrapProducts.remove(index); 
            }
        }
        if(SelectedWrapProducts.size() == 0) {
            RenderCart = false;
        }
    }
    
    public void checkout() {
        RenderInvoice = true;
        MakeItReadOnly = true;
    }
    
    /* ----------------------------------------------order section ------------------------------------------------------- */
    
    private String sortOrderBy ;
    private Decimal totalPrice = 0; 
    private Integer StartingPageRecordOrder {get;set;}
    private Integer EndingPageRecordOrder {get;set;}
    
    public ApexPages.StandardSetController setConOrder {
        get{
            if(setConOrder==null) {
                setConOrder = new ApexPages.StandardSetController(Database.query('SELECT ID,Price__c,Order_Status__c FROM Purchase_Order__c ORDER BY '+sortOrderBy+' DESC LIMIT 1000'));
            }
            return setConOrder;
        }
        set;
    }
    
    public Integer getStartingPageRecordOrder() {
        startingPageRecordOrder = setConOrder.getPageNumber() * setConOrder.getPageSize() - (setConOrder.getPageSize() - 1);
        return startingPageRecordOrder;
    }
    
    public Integer getEndingPageRecordOrder() {
        EndingPageRecordOrder = setConOrder.getPageNumber() * setConOrder.getPageSize() ;
        return Math.min(EndingPageRecordOrder,setConOrder.getResultSize());
    }
    
    public list<Purchase_Order__c> getOrders() {
        return (list<Purchase_Order__c>)setConOrder.getRecords();
    }
    
    public void sortOrder() {
        setConOrder = null;
        sortOrderBy = 'price__c';
    }
    
    public void addPurchase() {
        RenderProducts = true;
    }
    
    public Decimal getTotalOrderPrice() {
        totalPrice = 0; 
        for(Integer index = 0 ; index < SelectedWrapProducts.size() ; index++ ){
            totalPrice += SelectedWrapProducts[index].product.price_per_unit__c * SelectedWrapProducts[index].quantity;
        }
        return totalPrice;
    }
    
    public PageReference placeOrder() {
        Purchase_Order__c newOrder = new Purchase_Order__c(Price__c = totalPrice , Order_Status__c = 'Pending');
        insert newOrder ; 
        List<cart__c> productOrderLineItems = new List<cart__c>();
        List<Product2> productsToUpdate = new List<Product2>();
        for(wrapProduct wrap : SelectedWrapProducts) {
            productOrderLineItems.add( new cart__c(Purchase_Order__c = newOrder.Id , product__c = wrap.product.Id , quantity__c = wrap.quantity , 
                                                   total__c = wrap.quantity * wrap.product.price_per_unit__c , CartOrder_Status__c = 'Cleared'));
            productsToUpdate.add(wrap.product);
        }
        insert productOrderLineItems;
        update productsToUpdate;
        return new PageReference('/'+newOrder.Id);

    }  
}