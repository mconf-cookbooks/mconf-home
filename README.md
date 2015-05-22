mconf-home Cookbook
=================

Install Mconf-Home.

Requirements
------------

Ubuntu 12.04

e.g.
#### packages
- `toaster` - mconf-home needs toaster to brown your bagel.

Attributes
----------

e.g.
#### mconf-home::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['mconf-home']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### mconf-home::default

Just include `mconf-home` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[mconf-home]"
  ]
}
```
