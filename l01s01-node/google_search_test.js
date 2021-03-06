// Licensed to the Software Freedom Conservancy (SFC) under one
// or more contributor license agreements.  See the NOTICE file
// distributed with this work for additional information
// regarding copyright ownership.  The SFC licenses this file
// to you under the Apache License, Version 2.0 (the
// "License"); you may not use this file except in compliance
// with the License.  You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

/**
 * @fileoverview An example test that may be run using Mocha.
 *
 * Usage:
 *
 *     mocha -t 10000 selenium-webdriver/example/google_search_test.js
 *
 * You can change which browser is started with the SELENIUM_BROWSER environment
 * variable:
 *
 *     SELENIUM_BROWSER=chrome \
 *         mocha -t 10000 selenium-webdriver/example/google_search_test.js
 */

const {Builder, By, until} = require('selenium-webdriver');
const test = require('selenium-webdriver/testing');

test.describe('Google Search', function() {
  let driver;

  test.before(function *() {
    driver = yield new Builder().forBrowser('firefox').build();
  });

  // You can write tests either using traditional promises.
  it('works with promises', function() {
    return driver.get('http://www.ya.ru')
        .then(_ => driver.findElement(By.id('text')).sendKeys('webdriver'))
        .then(_ => driver.findElement(By.xpath("//div[@class='search2__button']/button")).click())
        .then(_ => driver.wait(until.titleContains('webdriver'), 10000));
  });

  // Or you can define the test as a generator function. The test will wait for
  // any yielded promises to resolve before invoking the next step in the
  // generator.
  test.it('works with generators', function*() {
    yield driver.get('http://www.ya.ru');
    yield driver.findElement(By.id('text')).sendKeys('webdriver');
    yield driver.findElement(By.xpath("//div[@class='search2__button']/button")).click();
    yield driver.wait(until.titleContains('webdriver'), 10000);
  });

  test.after(() => driver.quit());
});
