=head1 NAME

MooX::Zipper - immutable cursor onto a data structure

=head1 SYNOPSIS

See L<MooX::Zippable>

=cut

package MooX::Zipper;
use Moo;
with 'MooX::Zipper::Role::Eager', 'MooX::Zipper::Role::Untracked';
use MooX::Zippable::Autobox conditional=>1;

=head1 METHODS

All zippers have the following methods

=head2 C<$zipper-E<gt>go($accessor)>

Traverses to an accessor of the object, keeping a breadcrumb trail back to the previous
object, so that it knows how to zip all the data back up.

=head2 C<$zipper-E<gt>set($accessor =E<gt> $value)>

Seemingly "update" a field of the object.  In fact, behind the scenes, the zipper is
calling C<but> and returning a copy of the object with the values updated.

=head2 C<$zipper-E<gt>call($method =E<gt> @args)>

Assumes that C<$method> returns a copy of the same object.  As with C<set>, you can
imagine that C<call> is updating the object in place, but in fact behind the scenes
everything is immutable.  (In fact, C<set> is itself implemented as:
C<$zipper-E<gt>call( but => $accessor => $value )>)

=head2 C<$zipper-E<gt>up>

Go back up a level

=head2 C<$zipper-E<gt>top>

Go back to the top of the object.  The returned value is I<still> a zipper!  To
return the object instead, use C<focus>

=head2 C<$zipper-E<gt>focus>

Return to the top of the zipper, zipping up all the data you've changed using
C<call> and C<set>, and return the modified copy of the object.

=head2 Other zipper methods

It is possible to create zippers for specific classes.  Examples are supplied for
perl's native Hash, Array, and Scalar types, using autobox.  See the classes for
L<MooX::Zipper::Native>, L<MooX::Zipper::Hash>, L<MooX::Zipper::Array>,
L<MooX::Zipper::Scalar> for details.

=cut

1;
