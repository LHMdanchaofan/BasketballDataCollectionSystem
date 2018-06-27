//设置默认的分页参数
if ($.fn.datagrid){
    $.fn.datagrid.defaults.pageSize = 5;//这里一定要用datagrid.defaults.pageSize，用pagination.defaults.pageSize一直不行
    $.fn.datagrid.defaults.pageList = [5];//这里一定要有，不然上面的也不起效
}
//设置分页显示文字
if ($.fn.pagination){
    $.fn.pagination.defaults.beforePageText = '第';
    $.fn.pagination.defaults.afterPageText = '共{pages}页';
    $.fn.pagination.defaults.displayMsg = '显示{from}到{to},共{total}记录';
}