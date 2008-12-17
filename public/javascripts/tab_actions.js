var main = Ext.onReady(function(){

	// Menu containing actions
    var tabActions = new Ext.Panel({
		frame:true,
		title: 'Actions',
		collapsible:true,
		contentEl:'actions',
		titleCollapse: true
    });

    // Parent Panel to hold actions menu
    var actionPanel = new Ext.Panel({
    	id:'action-panel',
    	region:'west',
    	split:true,
    	collapsible: true,
    	collapseMode: 'mini',
    	width:200,
    	minWidth: 150,
    	border: false,
    	baseCls:'x-plain',
    	items: [tabActions]
    });

	// North Component
	var northComponent = new Ext.BoxComponent({ // raw
        region:'north',
        el: 'north',
        height:32
    });
    	    
  	// Tree Component
    var treePanel = new Ext.tree.TreePanel({
    	loader: new Ext.tree.TreeLoader({
          url:'/categories',
          requestMethod:'GET',
          baseParams:{format:'json'}
        }),
        renderTo:'category-tree',
        root: new Ext.tree.AsyncTreeNode(),
        rootVisible:false
    });

    // Main (Tabbed) Panel
    var tabPanel = new Ext.TabPanel({
		region:'center',
		deferredRender:false,
		autoScroll: true, 
		margins:'0 4 4 0',
		activeTab:0,
		items:[{
			id:'tab1',
			contentEl:'tabs',
    		title: 'Main',
    		closable:false,
    		autoScroll:true
		}]
    });
 
    // Configure viewport
    viewport = new Ext.Viewport({
		layout:'border',
		items:[northComponent, actionPanel, tabPanel]});
		// Adds tab to center panel
	    function addTab(tabId, tabTitle, targetUrl){
	        tabPanel.add({
			id: tabId,
		    title: tabTitle,
		    iconCls: 'tabs',
		    autoLoad: {url: targetUrl, callback: this.initSearch, scope: this, scripts: true},
		    closable:true
		}).show();
    }

    // Update the contents of a tab if it exists, otherwise create a new one
    updateTab = function updateTab(tabId, title, url) {
    	var tab = tabPanel.getItem(tabId);
		url = url + '?tabId=' + tabId + '&title=' + title;
    	if(tab){
    		tab.getUpdater().update(url);
    		tab.setTitle(title);
    	}else{
    		tab = addTab(tabId, title, url);
    	}
    	tabPanel.setActiveTab(tab);
    }

    // Verify when click on leaf element of tree
    treePanel.on('click', function(n){
		if(n.attributes.leaf == true)
			updateTab(n.attributes.parent_id, n.attributes.text, n.attributes.link);			
		else
			return false;
    });
	
	// Render the tree with values
    treePanel.render();
});