package TwoDimSelect::Plugin;

use strict;
use MT::Util qw( dirify );

sub load_customfield_types {
    return {
        twodim_select => {
            label => 'Drop Down Menu (2-Dimensional)',
            field_html => q{
<script type="text/javascript">
$(document).ready( function() {
  $('#<mt:var name="field_name">_parent').change( function() {
    $('.<mt:var name="field_id">-values').hide();
    var v;
    if ($('#<mt:var name="field_id">-' + $(this).val()).length > 0) {
      $('#<mt:var name="field_id">-' + $(this).val()).show();
      v = $('#<mt:var name="field_id">-' + $(this).val()).val()
    } else {
      v = $(this).val();
    }
    $('#<mt:var name="field_id">-value').val( v );
  });
  $('.<mt:var name="field_id">-values').change( function() {
    var v = $(this).val();
    $('#<mt:var name="field_id">-value').val( v );
  });
});
</script>
<input id="<mt:var name="field_id">-value" name="<mt:var name="field_name">" type="hidden" value="<mt:var name="value">" />
<select id="<mt:var name="field_name">_parent">
  <option value="">None Selected</option>
<mt:loop name="options_loop">
  <option value="<mt:var name="value">" <mt:if name="loop_selected"> selected</mt:if>><mt:var name="label"></option>
  <mt:setvarblock name="top_label"><mt:var name="label"></mt:setvarblock>
<mt:setvarblock name="extras" append="1">
  <mt:loop name="values_loop">
    <mt:if name="__first__"><select class="<mt:var name="field_id">-values" id="<mt:var name="field_id">-<mt:var name="top_label" dirify="1">" <mt:unless name="loop_selected">style="display: none;"</mt:unless>></mt:if>
    <option value="<mt:var name="value">"<mt:if name="selected"> selected</mt:if>><mt:var name="label"></option>
    <mt:if name="__last__"></select></mt:if>
  </mt:loop>
</mt:setvarblock>
</mt:loop>
</select>
<mt:var name="extras">
            },
            field_html_params => sub {
                my ($key, $tmpl_key, $tmpl_param) = @_;
                my $value = $tmpl_param->{options};
                my $hash;
                eval "\$hash = $value;";
                if ($@) {
                    MT->log("Error parsing twodimselect options hash: $@");
                }
                my @loop;
                foreach my $top (sort keys %$hash) {
                    my @loop2 = ();
                    my $selected = 0;
                    if ($hash->{$top}) {
                        my @vals = @{$hash->{$top}};
                        foreach my $scnd (sort @vals) {
                            my $v = dirify( $top . " " . $scnd );
                            if ($tmpl_param->{value} eq $v) {
                                $selected = 1;
                            }
                            push @loop2, {
                                'label'     => $scnd,
                                'value'     => $v,
                                'selected'  => $tmpl_param->{value} eq $v,
                            }
                        }
                    } else {
                        $selected = ($tmpl_param->{value} eq dirify($top));
                    }
                    push @loop, {
                        'label'         => $top,
                        'value'         => dirify($top),
                        'loop_selected' => $selected,
                        'values_loop'   => \@loop2,
                    };
                }
                $tmpl_param->{options_loop} = \@loop;
            },
            options_field => q{
<textarea class="full-width" rows="5" name="options"><mt:var name="options"></textarea>
            },
          no_default => 1,
          order => 500,
          column_def => 'vchar',
        }
    };
}

1;
__END__
