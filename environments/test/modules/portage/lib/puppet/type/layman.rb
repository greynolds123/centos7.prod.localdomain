Puppet::Type.newtype(:layman) do

  desc "The layman type to manage overlays"

  ensurable do
    defaultvalues
    defaultto :present
  end

  newparam(:name, :namevar => true) do
    desc "The name of the overlay"
  end
end
