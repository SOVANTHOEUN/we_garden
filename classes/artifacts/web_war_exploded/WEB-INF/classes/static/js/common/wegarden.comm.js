/**
 *
 */
var wegarden;
if(!wegarden) wegarden={};

if(!wegarden.comm) {wegarden.comm={};}

wegarden.comm.inputCurrency = function (targetId){


    $("#"+targetId).keydown(function (e) {
        // Allow: backspace, delete, tab, escape, enter and .
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
            // Allow: Ctrl+A, Command+A
            (e.keyCode === 65 && (e.ctrlKey === true || e.metaKey === true)) ||
            // Allow: home, end, left, right, down, up
            (e.keyCode >= 35 && e.keyCode <= 40)) {
            // let it happen, don't do anything
            return;
        }
        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
    });


    $("#"+targetId).focusout(function (e) {
        if(targetId != "lndWidth" && targetId != "lndHeight" && targetId != "lndArea"){
            $("#"+targetId).val(wegarden.comm.formatCurrency( $("#"+targetId).val() ));
        }

    });

};

wegarden.comm.inputCurrencyByClass = function (parentId,targetClass){
    $(parentId).on('keydown', targetClass, function (e) {
        //$("."+targetClass).keydown(function (e) {

        // Allow: backspace, delete, tab, escape, enter and .
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
            // Allow: Ctrl+A, Command+A
            (e.keyCode === 65 && (e.ctrlKey === true || e.metaKey === true)) ||
            // Allow: home, end, left, right, down, up
            (e.keyCode >= 35 && e.keyCode <= 40)) {
            // let it happen, don't do anything
            return;
        }
        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
    });

};

wegarden.comm.replaceAll = function(val, str1, str2 )
{
    var temp_str = val;
    if(temp_str == null || temp_str == "undefined" || temp_str == ""){
        return "";
    }else{
        temp_str = temp_str.replace(/(^\s*)|(\s*$)/gi, "");
        temp_str = temp_str.replace(eval("/" + str1 + "/gi"), str2);
        return temp_str;
    }
};

wegarden.comm.null2Void = function(val,option)
{
    if(val == null || val == "undefined" || val == "null" || val == "" || val == undefined){
        return option;
    }

    return val;
};

wegarden.comm.inputNumber = function (targetId){


    $("#"+targetId).keydown(function (e) {
        // Allow: backspace, delete, tab, escape, enter and .
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13]) !== -1 ||
            // Allow: Ctrl+A, Command+A
            (e.keyCode === 65 && (e.ctrlKey === true || e.metaKey === true)) ||
            // Allow: home, end, left, right, down, up
            (e.keyCode >= 35 && e.keyCode <= 40)) {
            // let it happen, don't do anything
            return;
        }
        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
    });

};


wegarden.comm.formatCurrency = function(val){
    if(wegarden.comm.nullToEmpty(val) == ""){
        return "";
    }
    val = wegarden.comm.nullToEmpty(val);
    val = val.toString().replace(/,/g, "");
    val = parseFloat(val);
    val = val.toString();
    val = val.replace(/\B(?=(\d{3})+(?!\d))/g, ",");

    /*
    value=val+"";
    value=val.replace(/,/g,"");
    var str = val.toString().split('.');
    if (str[0].length >= 4) {
        str[0] = str[0].replace(/(\d)(?=(\d{3})+$)/g, '$1,');
    }
    if (str[1] && str[1].length >= 4) {
        str[1] = str[1].replace(/(\d{3})/g, '$1 ');
    }
    return str.join(',');
    */

    return val;
};

wegarden.comm.formatDate = function(val){

    return val.split('-')[2]+"-"+val.split('-')[1]+"-"+val.split('-')[0];
}

/**
 *
 */
wegarden.comm.todayDate = function(target,format){
    format = String(format);
    var d  = new Date();

    var month = d.getMonth() + 1;
    var day   = d.getDate();

    var todayDate = (day<10 ? '0' : '') + day  + format + (month<10 ? '0' : '') + month  + format + d.getFullYear();
    $(target).val(todayDate);
}

wegarden.comm.alertMsg = function(val,id_focus,element_focus){
    $("#mdlAlert").css("border-radius","5px");
    $("#mdlAlert .modal-body").html("<p>"+val+"</p>");

    $("#mdlAlert").modal({ backdrop: 'static',keyboard: false });

    $('#mdlAlert').on('hidden.bs.modal', function (e) {

        var modalLeng = $('.modal').length;
        var chModal="f";
        for(var i=0; i < modalLeng; i++){
            if($('.modal').eq(i).css('display') != "none"){
                chModal = "t";
                break;
            }
        }
        if(chModal == "t"){
            $('body').addClass('modal-open');
        }
        if(id_focus != null && id_focus != undefined){
            $("#"+id_focus).focus();
        }
        if(element_focus != null && element_focus != undefined){
            element_focus.focus();
        }
        //$('body').addClass('modal-open');
    });

    var eqChk=$("div.modal-backdrop").length - 1;
    $("div.modal-backdrop").eq(eqChk).css("z-index","99998");
    $("div.modal-backdrop.show").eq(eqChk).css("opacity","0.2");

}

wegarden.comm.confirmMsg = function(val){

    $("#mdlConfirm .modal-body").html("<p>"+val+"</p>");
    $("#mdlConfirm").modal({ backdrop: 'static',keyboard: false });

    $('#mdlConfirm').on('hidden.bs.modal', function (e) {
        var modalLeng = $('.modal').length;
        var chModal="f";
        for(var i=0; i < modalLeng; i++){
            if($('.modal').eq(i).css('display') != "none"){
                chModal = "t";
                break;
            }
        }
        if(chModal == "t"){
            $('body').addClass('modal-open');
        }
    });

    var eqChk=$("div.modal-backdrop").length - 1;
    $("div.modal-backdrop").eq(eqChk).css("z-index","99998");
    $("div.modal-backdrop.show").eq(eqChk).css("opacity","0.2");

}

wegarden.comm.checkConfirmMsg = function(val){
    var chkBtn="";
    $("#btnConfirmCancel,#btnExitConfirm").click(function(e){
        $("#mdlConfirm").modal('hide');
        chkBtn="true";
    });
    $("#btnConfirmOk").click(function(e){
        $("#mdlConfirm").modal('hide');
        chkBtn="false";
    });
    return chkBtn;
}


wegarden.comm.isNull = function(dat){
    return dat==undefined||typeof(dat)==undefined||dat==null||(typeof(dat)=="string"&&$.trim(dat)=="");
};

wegarden.comm.nullToEmpty = function(val){
    if(val == "null" || val ==null || val == undefined || val == "undefined"){
        return "";
    }else{
        return val;
    }

};

wegarden.comm.isEmpty = function(val){
    if(val == "null" || val == null || val == undefined || val == "undefined" || val == ""){
        return true;
    }else{
        return false;
    }

};

wegarden.comm.renderYn = function(val){

    if(val =="Y"){
        return '<span class="label label-success lndStr" style ="background-color: #f0ad4e;color: white;padding: 2px;font-size: 11px;" data-val="Pay"> '+$.i18n.prop("lb_yes")+' </span>';
    }else{
        return '<span class="label label-warning lndStr" style ="background-color: #777;color: white;padding: 2px;font-size: 11px;" data-val="Wait">'+$.i18n.prop("lb_no")+'</span>';
    }
};

wegarden.comm.getComanyProfile = function(){
    var data =[];
    $.ajax({
        type: "POST",
        url: $("#base_url").val() +"User/selectCompanyData",
        dataType: 'json',
        async: false,
        success: function(res) {
            if (res){
                data= res.COM_REC;
            }else{
                console.log(data);
                wegarden.comm.alertMsg($.i18n.prop("msg_err"));
            }

        },
        error : function(data) {
            console.log(data);
            wegarden.comm.alertMsg($.i18n.prop("msg_err"));
        }
    });

    return data;
};

wegarden.comm.checkUserName = function(login_nm){
    var data=false;
    $.ajax({
        type: "POST",
        url: $("#base_url").val() +"User/checkUserName",
        dataType: 'json',
        async: false,
        data: {regLogNm: login_nm},
        success: function(res) {
            if (res){

                if(res.USER_REC.length >0){
                    data = true;
                }else{
                    data = false;
                }

            }

        },
        error : function(data) {
            console.log(data);
            wegarden.comm.alertMsg($.i18n.prop("msg_err"));
        }
    });


    return data;
};


wegarden.comm.getUserById = function(usr_id){
    var data=null;
    $.ajax({
        type: "POST",
        url: $("#base_url").val() +"User/select",
        dataType: 'json',
        async: false,
        data: {usrId: usr_id},
        success: function(res) {
            if (res){

                if(res.USER_REC.length >0){
                    data = res.USER_REC;
                }else{
                    data = null;
                }

            }

        },
        error : function(data) {
            console.log(data);
            wegarden.comm.alertMsg($.i18n.prop("msg_err"));
        }
    });


    return data;
};

/**
 *
 */
wegarden.comm.openPopUpForm = function(controller_nm, option, data, modal_size, id_popup, id_popup_content, id_iframe){
    var modalId  = "";
    var iframeId = "";
    var popupContentId = "";

    if(id_popup != undefined && id_popup !="" && id_popup != null){
        modalId = id_popup;
        popupContentId = id_popup_content;
        iframeId = $("#"+id_iframe);
    }else{
        modalId = "modalMd";
        popupContentId = "modalMdContent";
        iframeId = parent.$("#ifamewegardenForm");
    }
    //
    if(modal_size !="" && modal_size != null && modal_size != undefined){
        if(modal_size == "modal-sm" || modal_size == "modal-md" || modal_size == "modal-lg" ){
            parent.$("#"+modalId+" .modal-dialog").removeClass("modal-sm");
            parent.$("#"+modalId+" .modal-dialog").removeClass("modal-md");
            parent.$("#"+modalId+" .modal-dialog").removeClass("modal-lg");
            //
            parent.$("#"+modalId+" .modal-dialog").addClass(modal_size);
        }
    }
    $("#loading").show();
    var dataUrl = "";
    if(data != null && data != "" && data != undefined){
        dataUrl = "?"+data;
    }

    var iframe = iframeId;
    iframe.attr("src", $("#base_url").val()+controller_nm+dataUrl);
    iframe.show();
    parent.$("#"+modalId).modal({backdrop: "static"});

    parent.$("#"+modalId).removeClass();
    parent.$("#"+modalId).addClass(controller_nm);
    parent.$("#"+modalId).addClass("modal");
    parent.$("#"+modalId).addClass("fade");

    parent.$("#"+popupContentId).css("width", "");
    parent.$("#"+popupContentId).css("left", "");
    for(var key in option){
        parent.$("#"+popupContentId).css(key, option[key]);
    }

    // parent.$("#"+popupContentId).css("height", option["height"]);
    parent.$("#"+popupContentId).css("border-radius","5px");
    iframe.css("border-radius","5px");
    parent.$("#"+popupContentId).html(iframe);

};
/**
 *
 */
wegarden.comm.closePopUpForm = function(class_name,callback,data){
    $("."+class_name).modal("hide");
    if (typeof callback === "function") {
        callback(data);
    }
};

/**
 *
 */
wegarden.comm.openPopUpSelect = function(controller_nm, option, data, modal_size, id_popup, id_popup_content, id_iframe){
    var modalId= "";
    var popupContentId = "";
    var iframeId;
    if(id_popup != undefined && id_popup !="" && id_popup != null){
        modalId= id_popup;
        popupContentId = id_popup_content;
        iframeId = parent.$("#"+id_iframe);
    }else{
        modalId = "modalMdSelect";
        popupContentId = "modalMdContentSelect";
        iframeId = parent.$("#ifamewegardenSelect");
    }

    if(modal_size !="" && modal_size !=null && modal_size != undefined){
        if(modal_size == "modal-sm" || modal_size == "modal-md" || modal_size == "modal-lg" ){
            parent.$("#"+modalId+" .modal-dialog").removeClass("modal-sm");
            parent.$("#"+modalId+" .modal-dialog").removeClass("modal-md");
            parent.$("#"+modalId+" .modal-dialog").removeClass("modal-lg");
            //
            parent.$("#"+modalId+" .modal-dialog").addClass(modal_size);
        }
    }
    $("#loading").show();
    var dataUrl="";
    if(data !=null && data !="" && data != undefined){
        dataUrl="?"+data;
    }

    var iframe = iframeId;
    iframe.attr("src", $("#base_url").val()+controller_nm+dataUrl);
    iframe.show();
    parent.$("#"+modalId+"").modal({backdrop: "static"});

    parent.$("#"+modalId+"").removeClass();
    parent.$("#"+modalId+"").addClass(controller_nm);
    parent.$("#"+modalId+"").addClass("modal");
    parent.$("#"+modalId+"").addClass("fade");

    parent.$("#"+popupContentId+"").css("height",option["height"]);
    parent.$("#"+popupContentId+"").css("border-radius","5px");
    iframe.css("border-radius","5px");
    parent.$("#"+popupContentId+"").html(iframe);

};

wegarden.comm.renderPaging = function(target_id, per_page, total_rec, page_no){
    // $("#chkAllBranch").prop( "checked", false );
    // var numPaging = total_rec/per_page;
    // numPaging = parseInt(numPaging);
    //
    // var checkNumPaging = total_rec % per_page;
    // if(checkNumPaging != 0){
    //     numPaging=numPaging+1;
    // }
    // if(numPaging > 1){
    //     $("#"+target_id).html("");
    //     $("#"+target_id).show();
    //     var checkDotPageNo=false;
    //     var checkDrawPage=0;
    //     $("#goToPage").remove();
    //     //
    //     if(numPaging >5){
    //         var goHtml='<div id="goToPage" class="input-group input-group-sm pull-right" style="margin-left: 10px;    width: 80px;">';
    //         goHtml+='   <input type="text" class="form-control" id="txtGoToPage">';
    //         goHtml+='   <span class="input-group-btn">';
    //         goHtml+='   <button id="btnGoToPage" type="button" class="btn btn-primary btn-flat"><i class="fa fa-arrow-circle-right"></i></button>';
    //         goHtml+='   </span>';
    //         goHtml+='</div>'
    //         $(goHtml).insertBefore("#"+target_id);
    //
    //         wegarden.comm.inputNumber("txtGoToPage");
    //     }
    //
    //     //
    //     if(page_no > numPaging){
    //         page_no =numPaging;
    //         return;
    //     }else if(page_no <= 0){
    //         page_no = 1;
    //     }else if(isNaN(page_no)){
    //         page_no = 1;
    //     }
    //     //
    //
    //     var htmlFirst = "";
    //     htmlFirst += '<li class="page-first disabled"><a href="javascript:void(0)">«</a></li>';
    //     htmlFirst += '<li class="page-pre disabled"><a href="javascript:void(0)">‹</a></li>';
    //
    //     $("#"+target_id).append(htmlFirst);
    //     for(var i=1; i<=numPaging; i++){
    //         if(checkDrawPage==10){
    //             break;
    //         }
    //         var classActive="";
    //         var html="";
    //         if(page_no == i){
    //             classActive = "active";
    //         }
    //
    //         if((numPaging > 10) && checkDrawPage >= 8){
    //             //add last page
    //             if(numPaging > (parseInt(page_no)+3)){
    //                 html = "<li class='"+classActive+"'><a disabled style='cursor:default;pointer-events: none;' href='javascript:void(0)'>...</a></li>";
    //                 checkDrawPage+=1;
    //             }
    //
    //             html += "<li class='"+classActive+"' ><a href='javascript:void(0)'>"+numPaging+"</a></li>";
    //             checkDrawPage+=1;
    //             $("#"+target_id).append(html);
    //             break;
    //         }
    //
    //         if(page_no > 6 && numPaging >10){
    //             if(i > 1 && i < (page_no - 3)){
    //                 if(checkDotPageNo == false){
    //                     checkDotPageNo = true
    //                     html = "<li class='"+classActive+"'><a disabled style='cursor:default;pointer-events: none;' href='javascript:void(0)'>...</a></li>";
    //
    //                     checkDrawPage+=1;
    //                 }
    //             }else{
    //                 html = "<li class='"+classActive+"' ><a href='javascript:void(0)'>"+i+"</a></li>";
    //                 checkDrawPage+=1;
    //             }
    //         }else{
    //             html = "<li class='"+classActive+"'><a href='javascript:void(0)'>"+i+"</a></li>";
    //             checkDrawPage+=1;
    //         }
    //
    //         $("#"+target_id).append(html);
    //     }
    //
    //     var htmlLast = "";
    //     htmlLast += '';
    //     htmlLast += '<li class="page-next"><a href="javascript:void(0)">›</a></li>';
    //     htmlLast += '<li class="page-last"><a href="javascript:void(0)">»</a></li>';
    //     $("#"+target_id).append(htmlLast);
    //
    //
    // }else{
    //     $("#"+target_id).hide();
    //     $("#goToPage").remove();
    // }

};

wegarden.comm.drawTablePaging = function( div_id, callback, curPageNo, totRec/*totPage*/, recPerPage/*input_page_size*/,detailInput){

    var page_size = 10; //표시할 페이지 수
    var totPage = Math.ceil(totRec/recPerPage);
    var currentPage  = (curPageNo)?curPageNo:1;
    if(parseInt(currentPage) < 1) currentPage = 1;
    if(parseInt(currentPage) > parseInt(totPage)) currentPage = totPage;
    var lastBlock    = Math.ceil(totPage/page_size);
    var currentBlock = Math.ceil(currentPage/page_size);
    var firstPage     = currentBlock*page_size-page_size+1;
    var lastPage      = currentBlock*page_size;

    $("#"+div_id).children().remove();
    $("#"+div_id).prev(".combo_wrap").show();
    if(totPage > 0){
        $("#"+div_id).show();

        var firstHtml = "<li class=\"page-first\" id='paging_first'><a href=\"javascript:void(0)\">«</a></li>";
        var prevHtml  = "<li class=\"page-pre\" id='paging_pre'><a href=\"javascript:void(0)\">‹</a></li>";
        var nextHtml  = "<li class=\"page-next\" id='paging_next'><a href=\"javascript:void(0)\">›</a></li>";
        var lastHtml  = "<li class=\"page-last\" id='paging_last'><a href=\"javascript:void(0)\">»</a></li>";
        var pageHtml  = "";
        var countNum=0;

        for(var i = firstPage; i <= lastPage && i <= totPage;  i++){
            if(currentPage == i){
                pageHtml += "<li class='page-number pag_num active'><a href='javascript:void(0)'>"+i+"</a></li>";
            }else{
                pageHtml += "<li class='page-number pag_num'><a href='javascript:void(0)'>"+i+"</a></li>";
            }
        }
        // pageHtml += " </span>";

        $("#"+div_id).append(firstHtml);
        $("#"+div_id).append(prevHtml);
        $("#"+div_id).append(pageHtml);
        $("#"+div_id).append(nextHtml);
        $("#"+div_id).append(lastHtml);

        if(currentBlock != 1){
            $("#paging_first").addClass("on");
        }

        if(currentBlock != lastBlock){
            $("#paging_last").addClass("on");
        }

        if(currentPage != 1){
            $("#paging_pre"  ).addClass("on");
        }

        if(currentPage != totPage){
            $("#paging_next").addClass("on");
        }

    }else{
        $("#"+div_id).prev(".combo_wrap").hide();
    }


    var input = {};
    $("#"+div_id).find("#paging_first").click(function(){
        $(".layertype1").hide();
        if($(this).hasClass("on")==false){ return false;}

        if($.isFunction(callback)){
            if(detailInput==null) {
                input["PG_NO"] = "1";
                input["PAGE_NO"] = "1";
                callback(input);
            }else{
                detailInput["PG_NO"] = "1";
                detailInput["PAGE_NO"] = "1";
                callback(detailInput);
            }
        }
    });
    $("#"+div_id).find("#paging_pre").click(function(){
        $(".layertype1").hide();
        if($(this).hasClass("on")==false){ return false;}

        currentPage = Number(currentPage)-1;

        if(currentPage < 0) currentPage = 1;
        if($.isFunction(callback)){
            if(detailInput==null) {
                input["PG_NO"] = currentPage.toString();
                input["PAGE_NO"] = currentPage.toString();
                callback(input);
            }else{
                detailInput["PG_NO"] = currentPage.toString();
                detailInput["PAGE_NO"] = currentPage.toString();
                callback(detailInput);
            }
        }
    });
    $("#"+div_id).find("#paging_next").click(function(){
        $(".layertype1").hide();
        if($(this).hasClass("on")==false){ return false;}

        currentPage = Number(currentPage)+1;

        if(currentPage > totPage){
            currentPage = totPage;
        }

        if($.isFunction(callback)){
            if(detailInput==null) {
                input["PG_NO"] = currentPage.toString();
                input["PAGE_NO"] = currentPage.toString();
                callback(input);
            }else{
                detailInput["PG_NO"] = currentPage.toString();
                detailInput["PAGE_NO"] = currentPage.toString();
                callback(detailInput);
            }
        }
    });
    $("#"+div_id).find("#paging_last").click(function(){
        if($(this).hasClass("on")==false){ return false;}

        if($.isFunction(callback)){
            if(detailInput==null) {
                input["PG_NO"] = totPage.toString();
                input["PAGE_NO"] = totPage.toString();
                callback(input);
            }else{
                detailInput["PG_NO"] = totPage.toString();
                detailInput["PAGE_NO"] = totPage.toString();
                callback(detailInput);
            }
        }
    });
    $("#"+div_id).find(".pag_num a").click(function(){
        if($(this).hasClass("on")==true){ return false;}

        currentPage = $(this).html();

        if($.isFunction(callback)){
            if(detailInput==null) {
                input["PG_NO"] = currentPage.toString();
                input["PAGE_NO"] = currentPage.toString();
                callback(input);
            }else{
                detailInput["PG_NO"] = currentPage.toString();
                detailInput["PAGE_NO"] = currentPage.toString();
                callback(detailInput);
            }
        }
    });

    // $("#"+div_id).prev(".combo_wrap").find(".combo_style").click(function(e){
    //     $(this).find("ul").toggle();
    //     //Keeps the rest of the handlers from being executed
    //     e.stopImmediatePropagation();
    // });

    // $("#"+div_id).prev(".combo_wrap").find("ul li").click(function(e){
    //     $("#"+div_id).parents(".paging_wrap").find(".combo_style ul").hide();
    //     if($(".paging_wrap").find(".btn_combo_down span").text() != $(this).text()){
    //         $(".paging_wrap").find(".btn_combo_down span").text($(this).text());
    //         if(!(contentId == 'undefined' || contentId == null || contentId == "" || contentId == undefined)) {
    //             $.cookie("LIMIT"+contentId, Number($.trim($(this).text()).replace(/[^0-9]/gi, '')) ,{expires:20*365});
    //         }
    //         callback();
    //     }
    //     e.stopImmediatePropagation();
    // });

    // $("body").click(function(e){
    //     var _target = $(e.target);
    //     if(!_target.parents().is('.combo_wrap') && !_target.is('.btn_combo_down')){
    //         $("#"+div_id).parents(".paging_wrap").find(".combo_style ul").hide();
    //     }
    // });

}

wegarden.comm.checkAllTblChk = function(chk_id, tbl_id, class_tocheck){

    $("#"+chk_id).prop( "checked", false );

    $("#"+chk_id).click(function(e){
        if($("#"+chk_id).is(":checked")){
            $("#"+tbl_id+" tbody ."+class_tocheck+" input[type=checkbox]").prop( "checked", true );
            $("#"+tbl_id+" tbody tr").css("background-color","#f4f4f4");
        }else{
            $("#"+tbl_id+" tbody ."+class_tocheck+" input[type=checkbox]").prop( "checked", false );
            $("#"+tbl_id+" tbody tr").removeAttr("style");
        }
    });
    $("#"+tbl_id+" tbody").on("click", "."+class_tocheck+" input[type=checkbox]", function(e) {
        if($("#"+tbl_id+" tbody ."+class_tocheck+" input[type=checkbox]").length == $("#"+tbl_id+" tbody ."+class_tocheck+" input[type=checkbox]:checked").length){
            $("#"+chk_id).prop( "checked", true );
        }else{
            $("#"+chk_id).prop( "checked", false );
        }
        //
        if($(this).is(":checked")){
            $(this).parent().parent().css("background-color","#f4f4f4");
        }else{
            $(this).parent().parent().removeAttr("style");
        }
    });


};

/**
 *
 */
wegarden.comm.getBrnachType = function(target_id){
    $.ajax({
        type: "POST",
        url: $("#base_url").val() +"Branch/getBranchType",
        dataType: 'json',
        async: false,
        success: function(res) {
            if(res.OUT_REC.length > 0){
                $("#"+target_id+" option").remove();
                for(var i=0; i<res.OUT_REC.length; i++){
                    var braNm = (getCookie("lang") == "kh" ? res.OUT_REC[i]["bra_nm_kh"] : res.OUT_REC[i]["bra_nm"]);
                    $("#"+target_id).append("<option value='"+res.OUT_REC[i]["bra_type_id"]+"'>"+braNm+"</option>");
                }

            }else{
                console.log(res);
                wegarden.comm.alertMsg("System Error!!! PLease connect again.");
            }
        },
        error : function(data) {
            console.log(data);
            wegarden.comm.alertMsg("System Error!!! PLease connect again.");
        }
    });
};


/**
 *
 */
wegarden.comm.getBrnachSelect = function(target_id){
    $.ajax({
        type: "POST",
        url: $("#base_url").val() +"Branch/getBranch",
        dataType: 'json',
        async: false,
        success: function(res) {
            if(res.OUT_REC.length > 0){
                $("#"+target_id+" option").remove();
                for(var i=0; i<res.OUT_REC.length; i++){
                    var braNm = (getCookie("lang") == "kh" ? res.OUT_REC[i]["bra_nm_kh"] : res.OUT_REC[i]["bra_nm"]);
                    $("#"+target_id).append("<option value='"+res.OUT_REC[i]["bra_id"]+"'>"+braNm+"</option>");
                }

            }else{
                console.log(res);
                wegarden.comm.alertMsg("System Error!!! PLease connect again.");
            }
        },
        error : function(data) {
            console.log(data);
            wegarden.comm.alertMsg("System Error!!! PLease connect again.");
        }
    });
};

/**
 *
 */
wegarden.comm.getPositionSelect = function(target_id){
    $.ajax({
        type: "POST",
        url: $("#base_url").val() +"Position/getPositionData",
        dataType: 'json',
        async: false,
        success: function(res) {
            if(res.OUT_REC.length > 0){
                $("#"+target_id+" option").remove();
                for(var i=0; i<res.OUT_REC.length; i++){
                    var braNm = (getCookie("lang") == "kh" ? res.OUT_REC[i]["pos_nm_kh"] : res.OUT_REC[i]["pos_nm"]);
                    $("#"+target_id).append("<option value='"+res.OUT_REC[i]["pos_id"]+"'>"+braNm+"</option>");
                }

            }else{
                console.log(res);
                wegarden.comm.alertMsg("System Error!!! PLease connect again.");
            }
        },
        error : function(data) {
            console.log(data);
            wegarden.comm.alertMsg("System Error!!! PLease connect again.");
        }
    });
};

/**
 *
 */
wegarden.comm.inputPhoneKhmer = function (targetId){
    $("#"+targetId).keydown(function (e) {
        parent.$("#msgErr").hide();
        // Allow: backspace, delete, tab, escape, enter and .
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13]) !== -1 ||
            // Allow: Ctrl+A, Command+A
            (e.keyCode === 65 && (e.ctrlKey === true || e.metaKey === true)) ||
            // Allow: home, end, left, right, down, up
            (e.keyCode >= 35 && e.keyCode <= 40)) {
            // let it happen, don't do anything
            return;
        }
        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
    });

    $("#"+targetId).focusout(function (e) {
        var data = $(this).val();
        console.log(data+"aaa");
        if($(this).val().trim() != null && $(this).val().trim() != ""){
            if(data.length < 9 || data.length > 10){
                $(this).focus();
                parent.$("#msgShw").html("Please input valid phone number.");
                parent.$("#msgErr").show();
                return;
            }else{
                parent.$("#msgErr").hide();
            }
        }else{
            parent.$("#msgErr").hide();
        }
    });

};

wegarden.comm.renderIndentityType = function(target_id){
    $("#"+target_id).append("<option value=''>Please Select</option>");
    $("#"+target_id).append("<option value='KHIDN'>Khmer Identity</option>");
    $("#"+target_id).append("<option value='PASS'>Passport</option>");
    $("#"+target_id).append("<option value='FAMI'>Family Book</option>");
};

//@@ Add Camma per 3digits
wegarden.comm.numberWithCommas = function(str) {
    if(str == null || str == "" ) return "";

    if(str.length>1 && str[0]=="0" && str[1]==".") return str;
    if(str.length>1 && str[0]=="0") return str[1];
    //if(str.length>2 && str[0]=="0" && str[1]==".") return str;

    if(str[0]==".") return "0." ;
    if (str.split(".").lenght>2) return "";
    return str.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    //return str.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, ",");
};

wegarden.comm.numberWithDot = function(str) {
    if(str == null || str == "" ) return "";

    if(str.length>1 && str[0]=="0" && str[1]==".") return str;
    if(str.length>1 && str[0]=="0") return str[1];

    if(str[0]==".") return "0." ;

    return str.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    //return str.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, ",");
};

wegarden.comm.removeAllCommas = function(str){
    return str.replace(/,/g, "");
};

wegarden.comm.validateFloatKeyPress = function(el, evt) {
    var charCode = (evt.which) ? evt.which : event.keyCode;
    var number = el.value.split('.');
    if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    //just one dot
    if(number.length>1 && charCode == 46){
        return false;
    }
    //get the carat position
    var caratPos = getSelectionStart(el);
    var dotPos = el.value.indexOf(".");
    if( caratPos > dotPos && dotPos>-1 && (number[1].length > 1)){
        return false;
    }
    return true;
}

//thanks: http://javascript.nwbox.com/cursor_position/
function getSelectionStart(o) {
    if (o.createTextRange) {
        var r = document.selection.createRange().duplicate()
        r.moveEnd('character', o.value.length)
        if (r.text == '') return o.value.length
        return o.value.lastIndexOf(r.text)
    } else return o.selectionStart
}

wegarden.comm.numberOnly = function(e){
    // Allow: backspace, delete, tab, escape, enter and .
    if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110]) !== -1 ||
        // Allow: Ctrl+A, Command+A
        (e.keyCode === 65 && (e.ctrlKey === true || e.metaKey === true)) ||
        // Allow: home, end, left, right, down, up
        (e.keyCode >= 35 && e.keyCode <= 40)) {
        // let it happen, don't do anything
        return;
    }
    // Ensure that it is a number and stop the keypress
    if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105) ) {
        e.preventDefault();
    }
}

wegarden.comm.comma = function(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
};

    