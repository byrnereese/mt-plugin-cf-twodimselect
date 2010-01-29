package TwoDimSelect::Plugin;

use strict;

sub load_customfield_types {
    return {
        twodim_select => {
            label => 'Drop Down Menu (2-Dimensional)',
            field_html => q{
<script type="text/javascript">
$(document).ready( function() {
  $('#<mt:var name="field_name">_parent').change( function() {
    $('.<mt:var name="field_id">-values').hide();
    $('#<mt:var name="field_id">-' + $(this).val()).show();
  });
});
</script>
<select id="<mt:var name="field_name">_parent">
  <option value="">None Selected</option>
<mt:loop name="options_loop">
  <option value="<mt:var name="label" dirify="1">" <mt:if name="loop_selected"> selected</mt:if>><mt:var name="label"></option>
<mt:setvarblock name="extras" append="1">
  <mt:loop name="values_loop">
    <mt:if name="__first__"><select class="<mt:var name="field_id">-values" id="<mt:var name="field_id">-<mt:var name="label" dirify="1">" name="<mt:var name="field_name">" <mt:unless name="loop_selected">style="display: none;"</mt:unless>></mt:if>
    <option<mt:if name="selected"> selected</mt:if>><mt:var name="__value__"></option>
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
                my @loop;
                foreach (sort keys %$hash) {
                    my @loop2;
                    my @vals = @{$hash->{$_}};
                    my ($selected1,$selected2) = (0,0);
                    foreach (sort @vals) {
                        if ($tmpl_param->{value} eq $_) {
                            $selected1 = $selected2 = 1;
                        }
                        push @loop2, {
                            'selected'  => $selected2,
                            '__value__' => $_
                        }
                    }
                    push @loop, {
                        'label'         => $_,
                        'loop_selected' => $selected1,
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
