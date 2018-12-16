$(function()
{
    window.addEventListener('message', function(event)
    {
        var item = event.data;
        var buf = $('#wrap');
		$('#ems').html(event.data.ems);
		$('#police').html(event.data.police);
		$('#sheriff').html(event.data.sheriff);
		$('#taxi').html(event.data.taxi);
		$('#mecano').html(event.data.mecano);
		$('#cardealer').html(event.data.cardealer);
		$('#realestate').html(event.data.realestate);
		$('#playerCon').html(event.data.playerCon);
        buf.find('table').append("<tr class=\"heading\"><th>Nimi</th><th>Ammatti</th><th>Puh</th><th>Ping</th></tr>");
        if (item.meta && item.meta == 'close')
        {
            document.getElementById("ptbl").innerHTML = "";
            $('#wrap').hide();
            return;
        }
        buf.find('table').append(item.text);
        $('#wrap').show();
    }, false);
});
